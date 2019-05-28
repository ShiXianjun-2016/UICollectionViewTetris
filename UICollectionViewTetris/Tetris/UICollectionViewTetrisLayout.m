//
//  UICollectionViewTetrisLayout.m
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import "UICollectionViewTetrisLayout.h"

@interface UICollectionViewTetrisLayout ()

/**
 cell 布局信息 二维数组
 */
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *attributesArray;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *arrSectionContentHeight;

@end


@implementation UICollectionViewTetrisLayout


- (void)prepareLayout
{
    [super prepareLayout];
    
    self.attributesArray            = [NSMutableArray array];
    self.arrSectionContentHeight    = [NSMutableArray array];
    
    NSInteger sectionNumber = [self.collectionView numberOfSections];
    
    for (int i = 0; i < sectionNumber; i++) {
        
        NSMutableArray *sectionAttributesArray = [NSMutableArray new];
        
        NSInteger cellNumber = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j < cellNumber; j++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [sectionAttributesArray addObject:attributes];
        }
        [self.arrSectionContentHeight addObject:@(0)];
        [self.attributesArray addObject:sectionAttributesArray];
    }
    
    [self organizeLocationInformation];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize size = CGSizeMake(50, 50);
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    attributes.frame = CGRectMake(0, 0, size.width, size.height);
    attributes.size = size;
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arrAllAtts = [NSMutableArray array];
    for (NSArray *arr in self.attributesArray) {
        [arrAllAtts addObjectsFromArray:arr];
    }
    return arrAllAtts;
}

-(CGSize)collectionViewContentSize
{
    CGFloat width = self.collectionView.frame.size.width;
    
    return CGSizeMake(width, self.arrSectionContentHeight.lastObject.floatValue);
}


#pragma mark - 位置计算
/**
 *@ 计算思路
 *@ 使用扫描的方式进行查找cell合适的位置
 *@ todo: 以最大公约数为扫描粒度 可以优化时间
 */

- (void)organizeLocationInformation
{
    for (NSMutableArray *arr in self.attributesArray) {
        [self organizeLocationInformationSection:arr];
    }
}

- (void)organizeLocationInformationSection:(NSMutableArray<UICollectionViewLayoutAttributes *> *)arrAttributes
{
    // 淘汰线 淘汰线之前的位置信息不需要计算 优化计算次数
    CGFloat eliminationLine = 0;
    for (int i = 0; i < arrAttributes.count; i++) {
        
        eliminationLine = [self organizeLocationInformationCell:arrAttributes[i]
                                                        foreArr:[arrAttributes subarrayWithRange:NSMakeRange(0, i)]
                                                eliminationLine:eliminationLine];
        
    }
}

/**
 计算出每个cell的frame

 @param attributes 当前cell的信息
 @param foreArr 当前cell前面的cell信息数组
 @param eliminationLine 淘汰线
 @return 更新后的淘汰线位置
 */
- (CGFloat)organizeLocationInformationCell:(UICollectionViewLayoutAttributes *)attributes
                                   foreArr:(NSArray<UICollectionViewLayoutAttributes *> *)foreArr
                           eliminationLine:(CGFloat)eliminationLine

{
    if (foreArr.count == 0) {
        
        CGFloat basicsY = 0;
        if (attributes.indexPath.section > 0) {
            basicsY = self.arrSectionContentHeight[attributes.indexPath.section - 1].floatValue;
        }
        
        attributes.frame = CGRectMake(0, basicsY, attributes.size.width, attributes.size.height);
        return eliminationLine;
    }
    
    CGPoint leftTopPoint = CGPointMake(0, NSUIntegerMax);
    
    // 依据右上角检查
    
    for (UICollectionViewLayoutAttributes *att in foreArr) {
        
        CGPoint originPoint = CGPointMake(att.frame.origin.x + att.size.width, att.frame.origin.y);
        
        if ([self checkIfAvailableWithPoint:originPoint attributes:attributes foreArr:foreArr]) {
            if ([self needRecordNewPointWithleftTopPoint:leftTopPoint newPoint:originPoint]) {
                leftTopPoint = originPoint;
            }
        }

    }
    
    if (leftTopPoint.y == NSUIntegerMax) {
        
        // 依据左下角检查
        for (UICollectionViewLayoutAttributes *att in foreArr) {
            
            CGPoint originPoint = CGPointMake(att.frame.origin.x, att.frame.origin.y + att.frame.size.height);
            
            if ([self checkIfAvailableWithPoint:originPoint attributes:attributes foreArr:foreArr]) {
                if ([self needRecordNewPointWithleftTopPoint:leftTopPoint newPoint:originPoint]) {
                    leftTopPoint = originPoint;
                }
            }
        }
        
    }
    
    attributes.frame = CGRectMake(leftTopPoint.x, leftTopPoint.y, attributes.size.width, attributes.size.height);
    
    NSNumber *contentHeight = self.arrSectionContentHeight[attributes.indexPath.section];
    CGFloat itemBottom = attributes.frame.origin.y + attributes.frame.size.height;
    if (contentHeight.floatValue < itemBottom) {
        self.arrSectionContentHeight[attributes.indexPath.section] = @(itemBottom);
    }
    
    return eliminationLine;
}

- (BOOL)needRecordNewPointWithleftTopPoint:(CGPoint)leftTopPoint
                                  newPoint:(CGPoint)newPoint
{
    if (newPoint.y < leftTopPoint.y) {
        return YES;
    }
    if (newPoint.y == leftTopPoint.y) {
        if (newPoint.x < leftTopPoint.x) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)checkIfAvailableWithPoint:(CGPoint)originPoint
                       attributes:(UICollectionViewLayoutAttributes *)attributes
                          foreArr:(NSArray<UICollectionViewLayoutAttributes *> *)foreArr
{
    
    CGFloat itemRight  = originPoint.x + attributes.size.width;
    if (itemRight > self.collectionViewContentSize.width) {
        return NO;
    }
    
    CGRect originFrame = CGRectMake(originPoint.x, originPoint.y, attributes.size.width, attributes.size.height);
    for (UICollectionViewLayoutAttributes *att in foreArr) {
        if (CGRectIntersectsRect(originFrame, att.frame)) {
            return NO;
        }
    }
    
    return YES;
}

@end
