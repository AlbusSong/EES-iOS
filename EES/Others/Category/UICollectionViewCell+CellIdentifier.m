//
//  UICollectionViewCell+CellIdentifier.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "UICollectionViewCell+CellIdentifier.h"


@implementation UICollectionViewCell (CellIdentifier)

+ (NSString *)cellIdentifier {
    return [NSString stringWithFormat:@"%@Identifier", NSStringFromClass([self class])];
}

@end
