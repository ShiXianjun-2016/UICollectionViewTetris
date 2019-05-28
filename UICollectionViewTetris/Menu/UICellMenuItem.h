//
//  UICellMenuItem.h
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICellMenuItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICellMenuItem : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (nonatomic, strong) UICellMenuItemModel *cellModel;

- (void)viewAnimation;

@end

NS_ASSUME_NONNULL_END
