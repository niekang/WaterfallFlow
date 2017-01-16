//
//  ViewController.m
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/13.
//  Copyright © 2017年 聂康 . All rights reserved.
//

#import "ViewController.h"
#import "WaterfallFlowLayout.h"
#import "WaterFlowCollectionViewCell.h"

static NSString *const cellIden = @"WaterFlow";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterfallFlowLayoutDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
}

- (void)loadSubviews{
    WaterfallFlowLayout *flowLayout = [[WaterfallFlowLayout alloc] init];
    flowLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[WaterFlowCollectionViewCell class] forCellWithReuseIdentifier:cellIden];
    
    [_collectionView reloadData];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIden forIndexPath:indexPath];
    cell.textLab.textColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    cell.textLab.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    cell.textLab.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.textLab.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - WaterfallFlowLayoutDelegate
- (CGFloat)waterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    //在这里根据需要展示的东西的宽高比算出需要显示的高度
    return arc4random_uniform(100)+30;
}

- (NSInteger)columeCountInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout{
    return 3;
}

- (CGFloat)lineSpaceInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout{
    return 10;
}

- (CGFloat)itemSpaceInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout{
    return 10;
}

- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout{
    return UIEdgeInsetsMake(20, 10, 10, 10);
}

@end
