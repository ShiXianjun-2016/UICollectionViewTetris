//
//  UICellMenuItemModel.h
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICellMenuItemModel : NSObject

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, strong) UIColor   *bgColor;
@property (nonatomic, strong) NSString  *title;

@property (nonatomic, assign) BOOL animationFlag;

+ (instancetype)cellMenuItemModelWithItemWidth:(CGFloat)itemWidth
                                    itemHeight:(CGFloat)itemHeight
                                       bgColor:(UIColor *)bgColor
                                         title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
