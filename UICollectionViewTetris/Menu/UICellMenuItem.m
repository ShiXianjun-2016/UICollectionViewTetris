//
//  UICellMenuItem.m
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import "UICellMenuItem.h"

@implementation UICellMenuItem

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 1;
}

- (void)setCellModel:(UICellMenuItemModel *)cellModel
{
    if (_cellModel != cellModel) {
        _cellModel = cellModel;
    }
    
    self.backgroundColor    = _cellModel.bgColor;
    self.lblTitle.text      = _cellModel.title;
}

@end
