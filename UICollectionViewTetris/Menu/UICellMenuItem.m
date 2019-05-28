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
    if (_cellModel.animationFlag) {
        self.contentView.backgroundColor = UIColor.blackColor;
    }else{
        self.contentView.backgroundColor = _cellModel.bgColor;
    }
    
    self.lblTitle.text                  = _cellModel.title;
}


- (void)viewAnimation
{
    self.cellModel.animationFlag = !self.cellModel.animationFlag;
    
    [UIView transitionWithView:self.contentView duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        if (self.cellModel.animationFlag) {
            self.contentView.backgroundColor = UIColor.blackColor;
        }else{
            self.contentView.backgroundColor = self.cellModel.bgColor;
        }
        
    } completion:nil];
    
}
@end
