//
//  PhotoObtainingTool.h
//  WanTuPaiApp
//
//  Created by Albus on 2019/5/9.
//  Copyright © 2019 WanTuPai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PhotosTypes.h>
#import "MacroOfEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoObtainingTool : NSObject

@property (nonatomic) BOOL canEditImage;
//@property (nonatomic, copy) NSArray *mediaTypes;
@property (nonatomic) PhotoObtainingToolResourceType resourceType;
@property (nonatomic) BOOL shouldShowHudWhenProcessingVideo;

+ (instancetype)sharedInstance;

+ (void)requireAuthority;
+ (void)tryToGetNewestImageFromPhotosWithSize:(CGSize)size mediaType:(PHAssetMediaType)mediaType finishHandler:(void (^) (UIImage *newestImage))finishHandler;
+ (BOOL)photoLibraryAvailable;

- (void)choosePhotoWithType:(UIImagePickerControllerSourceType)type atVC:(UIViewController *)vc completionHandler:(void (^) (NSString *imageLocalPath))completionHandler;
- (void)choosePhotoWithType:(UIImagePickerControllerSourceType)type completionHandler:(void (^) (NSString *imageLocalPath))completionHandler;

@end

NS_ASSUME_NONNULL_END
