//
//  UICollectionViewTetrisLayout.h
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewDelegateTetrisLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewTetrisLayout : UICollectionViewLayout

@property (nonatomic, weak) id <UICollectionViewDelegateTetrisLayout> delegate;

@end

NS_ASSUME_NONNULL_END
