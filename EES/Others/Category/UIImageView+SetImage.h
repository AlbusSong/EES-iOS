//
//  UIImageView+SetImage.h
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SetImage)

- (void)customSetImageWithImageURL:(NSString *)imageURL;
- (void)customSetImageWithImageURL:(NSString *)imageURL animated:(BOOL)animated;
- (void)customSetImageWithImageURL:(NSString *)imageURL placeholderImage:(nullable UIImage *)placeholderImage animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
