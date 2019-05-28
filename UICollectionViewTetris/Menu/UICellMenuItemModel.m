//
//  UICellMenuItemModel.m
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import "UICellMenuItemModel.h"

@implementation UICellMenuItemModel

+ (instancetype)cellMenuItemModelWithItemWidth:(CGFloat)itemWidth
                                    itemHeight:(CGFloat)itemHeight
                                       bgColor:(UIColor *)bgColor
                                         title:(NSString *)title
{
    UICellMenuItemModel *cellModel = [UICellMenuItemModel new];
    
    cellModel.itemWidth     = itemWidth;
    cellModel.itemHeight    = itemHeight;
    cellModel.bgColor       = bgColor;
    cellModel.title         = title;
    
    return cellModel;
}

@end
