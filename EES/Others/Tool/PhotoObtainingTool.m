//
//  PhotoObtainingTool.m
//  WanTuPaiApp
//
//  Created by Albus on 2019/5/9.
//  Copyright © 2019 WanTuPai. All rights reserved.
//


#import "PhotoObtainingTool.h"
#import <Photos/Photos.h>

@interface PhotoObtainingTool () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) void (^completionHandler) (NSString *imageLocalPath);

@end

static PhotoObtainingTool *instance = nil;

@implementation PhotoObtainingTool

+ (instancetype)sharedInstance {
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    
    return instance;
}

- (instancetype)init {
    if (instance) {
        return instance;
    }
    
    self = [super init];
    if (self) {
        self.canEditImage = NO;
        
        self.resourceType = PhotoObtainingToolResourceTypeBoth;
        self.shouldShowHudWhenProcessingVideo = NO;
        
        [PhotoObtainingTool requireAuthority];
    }
    return self;
}

+ (void)requireAuthority {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusAuthorized: //已获取权限
                break;
                
            case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
                break;
                
            case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
                break;
                
            default://其他。。。
                break;
        }
    }];
}

+ (void)tryToGetNewestImageFromPhotosWithSize:(CGSize)size mediaType:(PHAssetMediaType)mediaType finishHandler:(void (^) (UIImage *newestImage))finishHandler {
    if ([self photoLibraryAvailable] == NO) {
        return;
    }
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithMediaType:mediaType options:options];
    if (assetsFetchResults.count == 0) {
        return;
    }
    
    PHAsset *asset = assetsFetchResults.firstObject;
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    CGSize targetSize = CGSizeMake(size.width * UIScreen.mainScreen.scale, size.height * UIScreen.mainScreen.scale);
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFit options:requestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        NSLog(@"PHImageRequestOptionsDeliveryModeFastFormat: %@", [NSThread currentThread]);
        if (result.size.width > 0 && finishHandler) {            
            finishHandler(result);
        }
    }];
}

+ (BOOL)photoLibraryAvailable {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return (status == PHAuthorizationStatusAuthorized);
}

- (void)choosePhotoWithType:(UIImagePickerControllerSourceType)type atVC:(UIViewController *)vc completionHandler:(void (^) (NSString *imageLocalPath))completionHandler {
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = type;
    if (type == UIImagePickerControllerSourceTypeCamera) {
        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = self.canEditImage;
    
    if (self.resourceType == PhotoObtainingToolResourceTypeBoth) {
        imagePickerVC.mediaTypes = @[(NSString*)kUTTypeImage, (NSString*)kUTTypeMovie];
    } else if (self.resourceType == PhotoObtainingToolResourceTypeImage) {
        imagePickerVC.mediaTypes = @[(NSString*)kUTTypeImage];
    } else if (self.resourceType == PhotoObtainingToolResourceTypeVideo) {
        imagePickerVC.mediaTypes = @[(NSString*)kUTTypeMovie];
    }
    
    imagePickerVC.videoQuality = UIImagePickerControllerQualityTypeHigh;
    if (type == UIImagePickerControllerSourceTypeCamera) {
        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
    //    imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //    imagePickerVC.showsCameraControls = NO;
    [vc presentViewController:imagePickerVC animated:YES completion:nil];
    self.completionHandler = completionHandler;
}

- (void)choosePhotoWithType:(UIImagePickerControllerSourceType)type completionHandler:(void (^) (NSString *imageLocalPath))completionHandler {
    [self choosePhotoWithType:type atVC:[UIApplication sharedApplication].delegate.window.rootViewController completionHandler:completionHandler];
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    NSLog(@"didFinishPickingMediaWithInfo: %@", info);
    
    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
    
    WS(weakSelf)
    if ([mediaType isEqualToString:@"public.image"]) {
        // 图片
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        if (self.canEditImage) {
            image = info[@"UIImagePickerControllerEditedImage"];
        }
        NSString *imageLocalPath = [self saveImageToSandBoxWithImage:image];
        
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            imageLocalPath = [self saveImageToSandBoxWithImage:info[@"UIImagePickerControllerOriginalImage"]];
        } else {
            NSURL *imageUrl = info[@"UIImagePickerControllerImageURL"];
            if (self.canEditImage == NO && imageUrl) {
                imageLocalPath = imageUrl.absoluteString;
                if ([imageLocalPath hasPrefix:@"file://"]) {
                    imageLocalPath = [imageLocalPath substringFromIndex:[@"file://" length]];
                }
            }
        }
        
        if (imageLocalPath == nil) {
            imageLocalPath = @"";
        }
        
        if (self.completionHandler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.completionHandler(imageLocalPath);
            });
        }
    } else if ([mediaType isEqualToString:@"public.movie"]) {
        // 视频处理
        if (self.shouldShowHudWhenProcessingVideo) {
            [SVProgressHUD show];
        }
        
        NSString *videoLocalPath = [self saveVideoToSandBox];
        NSURL *videoUrl = info[@"UIImagePickerControllerMediaURL"];
        NSError *errorToCopyVideo;
        [[NSFileManager defaultManager] copyItemAtURL:videoUrl toURL:[NSURL fileURLWithPath:videoLocalPath] error:&errorToCopyVideo];
        if (errorToCopyVideo) {
            [SVProgressHUD showInfoWithStatus:@"视频加载失败，请重试"];
        }
        
        if (self.shouldShowHudWhenProcessingVideo) {
            [SVProgressHUD dismiss];
        }
        
        if (self.completionHandler) {
            self.completionHandler(videoLocalPath);
        }
        
//        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
//        options.networkAccessAllowed = YES;
//        options.deliveryMode = PHVideoRequestOptionsDeliveryModeHighQualityFormat;
//        options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//            NSLog(@"progressHandler: %@", [NSThread currentThread]);
//        };
//        [[PHImageManager defaultManager] requestExportSessionForVideo:info[@"UIImagePickerControllerPHAsset"] options:options exportPreset:AVAssetExportPresetHighestQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
//            [weakSelf videoExportActionWithSession:exportSession];
//        }];
    }
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark AVAssetExportSession

//- (void)videoExportActionWithSession:(AVAssetExportSession *)exportSession {
//
//    exportSession.shouldOptimizeForNetworkUse = YES;
//    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
//    NSString *mp4Path = [self saveVideoToSandBox];
//    exportSession.outputURL = [NSURL fileURLWithPath:mp4Path];
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"exportSession.progress: %f", exportSession.progress);
//            if (self.shouldShowHudWhenProcessingVideo) {
//                if (exportSession.progress < 1.0) {
//                    [SVProgressHUD showProgress:exportSession.progress status:@"视频处理中..."];
//                }
//            }
//            switch (exportSession.status) {
//                case AVAssetExportSessionStatusUnknown: {
//                    NSLog(@"AVAssetExportSessionStatusUnknown");
//                }
//                    break;
//                case AVAssetExportSessionStatusWaiting: {
//                    NSLog(@"AVAssetExportSessionStatusWaiting");
//                }
//                    break;
//                case AVAssetExportSessionStatusExporting: {
//                    NSLog(@"AVAssetExportSessionStatusExporting");
//                }
//                    break;
//                case AVAssetExportSessionStatusCompleted: {
//                    NSLog(@"AVAssetExportSessionStatusCompleted");
//                    [SVProgressHUD dismiss];
//                    if (self.completionHandler) {
//                        self.completionHandler(mp4Path);
//                    }
//                }
//                    break;
//                case AVAssetExportSessionStatusFailed: {
//                    NSLog(@"AVAssetExportSessionStatusFailed");
//                    [SVProgressHUD showInfoWithStatus:@"视频转换发生错误"];
//                }
//                    break;
//                case AVAssetExportSessionStatusCancelled: {
//                    NSLog(@"AVAssetExportSessionStatusCancelled");
//                    [SVProgressHUD showInfoWithStatus:@"视频转换操作取消"];
//                }
//                    break;
//            }
//        });
//    }];
//}

#pragma mark private action

- (NSString *)saveVideoToSandBox {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *videoDir = [tmpDir stringByAppendingString:@"Videos/"];
    [fileMgr createDirectoryAtPath:videoDir withIntermediateDirectories:YES attributes:nil error:nil];
    NSInteger random = arc4random()%1000000;
    NSString *videoPath = [videoDir stringByAppendingFormat:@"%li.mov", random];
    while ([fileMgr fileExistsAtPath:videoPath]) {
        random = arc4random()%1000000;
        videoPath = [videoDir stringByAppendingFormat:@"%li.mov", random];
    }
    NSLog(@"videoPathvideoPath: %@", videoPath);

    return videoPath;
}

- (NSString *)saveImageToSandBoxWithImage:(UIImage *)image {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSString *tmpDir = NSTemporaryDirectory();
    //    NSString *tmpDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSInteger random = arc4random()%1000000;
    NSString *imagePath = [tmpDir stringByAppendingFormat:@"%li.jpeg", random];
    while ([fileMgr fileExistsAtPath:imagePath]) {
        random = arc4random()%1000000;
        imagePath = [tmpDir stringByAppendingFormat:@"%li.jpeg", random];
    }
    
    UIImage *portraitOrientationImage = [GlobalTool fixOrientation:image];
    
    BOOL shouldSmallizeImage = NO;
    CGSize imgSize = portraitOrientationImage.size;
    CGSize newSize = imgSize;
    CGFloat maxWidth = ScreenW*2.0;
    CGFloat maxHeight = ScreenH*2.0;
    if ((imgSize.width > maxWidth) && (imgSize.height > maxHeight)) {
        shouldSmallizeImage = YES;
        
        CGFloat horizontalRatio = imgSize.width*1.0/maxWidth;
        CGFloat verticalRatio = imgSize.height*1.0/maxHeight;
        
        CGFloat ratio = horizontalRatio;
        if (verticalRatio < ratio) {
            ratio = verticalRatio;
        }
        
        newSize.width = imgSize.width/ratio;
        newSize.height = imgSize.height/ratio;
    }
    
    //    [UIImagePNGRepresentation(shouldSmallizeImage ? [self smallizeImage:portraitOrientationImage toSize:newSize] : portraitOrientationImage) writeToFile:imagePath atomically:YES];
    // 改用JPEG格式保存，因为这样的图片尺寸更小
    [UIImageJPEGRepresentation(shouldSmallizeImage ? [self smallizeImage:portraitOrientationImage toSize:newSize] : portraitOrientationImage, 0.7) writeToFile:imagePath atomically:YES];
    
    return imagePath;
}

- (UIImage *)smallizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end

