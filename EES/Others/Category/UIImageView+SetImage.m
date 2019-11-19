//
//  UIImageView+SetImage.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "UIImageView+SetImage.h"



@implementation UIImageView (SetImage)

- (void)customSetImageWithImageURL:(NSString *)imageURL {
    [self customSetImageWithImageURL:imageURL animated:NO];
}

- (void)customSetImageWithImageURL:(NSString *)imageURL animated:(BOOL)animated {
    [self customSetImageWithImageURL:imageURL placeholderImage:nil animated:animated];
}

- (void)customSetImageWithImageURL:(NSString *)imageURL placeholderImage:(nullable UIImage *)placeholderImage animated:(BOOL)animated {
    
    NSString *confirmingImageUrl = imageURL;
    
    if ([imageURL hasSuffix:@"svg"]) {
        NSString *tmpUrl = [imageURL substringToIndex:(imageURL.length - 3)];
        confirmingImageUrl = [tmpUrl stringByAppendingString:@"png"];
    }
    
    
    [self sd_setImageWithURL:[NSURL URLWithString:confirmingImageUrl] placeholderImage:placeholderImage options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.image = image;
            if (animated) {
                self.alpha = 0.0;
                [UIView animateWithDuration:0.3 animations:^{
                    self.alpha = 1.0;
                }];
            }
        }
    }];
}

@end
