//
//  UIControllerMenu.m
//  UICollectionViewTetris
//
//  Created by 石显军 on 2019/5/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import "UIControllerMenu.h"
#import "UICellMenuItem.h"
#import "UICellMenuItemModel.h"
#import "UICollectionViewTetrisLayout.h"

@interface UIControllerMenu ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateTetrisLayout>

@property (nonatomic, strong) NSMutableArray<UICellMenuItemModel *> *arrCellModels;

@end

@implementation UIControllerMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializationData];
    
    [self initializationView];
}

#pragma mark - Private
- (void)initializationData
{
    self.arrCellModels = [NSMutableArray array];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat itemWidth_1 = screenWidth / 1.f;
    CGFloat itemWidth_2 = screenWidth / 2.f;
    CGFloat itemWidth_3 = screenWidth / 3.f;
    CGFloat itemWidth_4 = screenWidth / 4.f;
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_1
                                                                           itemHeight:60
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"1"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_2
                                                                           itemHeight:itemWidth_2
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"2"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"3"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"4"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"5"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"6"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"7"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"8"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_2
                                                                           itemHeight:itemWidth_2
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"9"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"10"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_4
                                                                           itemHeight:itemWidth_4
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"11"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_3
                                                                           itemHeight:itemWidth_3
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"12"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_3
                                                                           itemHeight:itemWidth_3
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"13"]];
    
    [self.arrCellModels addObject:[UICellMenuItemModel cellMenuItemModelWithItemWidth:itemWidth_3
                                                                           itemHeight:itemWidth_3
                                                                              bgColor:[self getRandomColor]
                                                                                title:@"14"]];
    
}

- (void)initializationView
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"UICellMenuItem" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:@"UICellMenuItem"];
    
    UICollectionViewTetrisLayout *tetrisLayout = (UICollectionViewTetrisLayout *)self.collectionViewLayout;
    tetrisLayout.delegate = self;
}

- (UIColor *)getRandomColor
{
    CGFloat randomR = arc4random_uniform(256) / 255.f;
    CGFloat randomG = arc4random_uniform(256) / 255.f;
    CGFloat randomB = arc4random_uniform(256) / 255.f;
    
    return [UIColor colorWithRed:randomR green:randomG blue:randomB alpha:1];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrCellModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICellMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICellMenuItem" forIndexPath:indexPath];
    cell.cellModel = self.arrCellModels[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateTetrisLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICellMenuItemModel *cellModel = self.arrCellModels[indexPath.row];
    return CGSizeMake(cellModel.itemWidth, cellModel.itemHeight);
}

@end
