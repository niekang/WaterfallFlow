//
//  WaterfallFlowLayout.h
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

/*
 注意：若是没有使用约束布局视图，那么UICollectionViewCell上的子视图需要在layoutSubviews中设置frame刷新布局，若是使用了约束那么就不需要重写layoutSubviews了.
 **/
#import <UIKit/UIKit.h>

@class WaterfallFlowLayout;

@protocol WaterfallFlowLayoutDelegate <NSObject>

@required
//返回item的高度
- (CGFloat)waterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
//展示的列数
- (NSInteger)columeCountInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
//列与列之间的距离
- (CGFloat)itemSpaceInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
//行与行之间的距离
- (CGFloat)lineSpaceInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;
//边距设置
- (UIEdgeInsets)edgeInsetsInWaterfallFlowLayout:(WaterfallFlowLayout *)waterfallFlowLayout;

@end

@interface WaterfallFlowLayout : UICollectionViewLayout

@property (nonatomic, weak)id <WaterfallFlowLayoutDelegate> delegate;

@end
