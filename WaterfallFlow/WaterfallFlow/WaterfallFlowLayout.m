//
//  WaterfallFlowLayout.m
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

#import "WaterfallFlowLayout.h"

@interface WaterfallFlowLayout ()

@property (nonatomic, assign)NSInteger columeCount;

@property (nonatomic, assign)CGFloat contentHeight;

@property (nonatomic, assign)CGFloat itemSpace;

@property (nonatomic, assign)CGFloat lineSpace;

@property (nonatomic, assign)UIEdgeInsets edgeInsets;

@property (nonatomic, strong)NSMutableArray *atrributesArrary;

@property (nonatomic, strong)NSMutableArray *columeHeightArray;

@end

@implementation WaterfallFlowLayout

#pragma mark - 懒加载
- (NSMutableArray *)atrributesArrary{
    if (!_atrributesArrary) {
        _atrributesArrary = [NSMutableArray array];
    }
    return _atrributesArrary;
}

- (NSMutableArray *)columeHeightArray{
    if (!_columeHeightArray) {
        _columeHeightArray = [NSMutableArray array];
    }
    return _columeHeightArray;
}

#pragma mark - getter
- (NSInteger)columeCount{
    if (self.delegate && [self.delegate respondsToSelector:@selector(columeCountInWaterfallFlowLayout:)]) {
        return [self.delegate columeCountInWaterfallFlowLayout:self];
    }else{
        return 3;
    }
}

- (CGFloat)lineSpace{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineSpaceInWaterfallFlowLayout:)]) {
        return [self.delegate lineSpaceInWaterfallFlowLayout:self];
    }else{
        return 0;
    }
}

- (CGFloat)itemSpace{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSpaceInWaterfallFlowLayout:)]) {
        return [self.delegate itemSpaceInWaterfallFlowLayout:self];
    }else{
        return 0;
    }
}

- (UIEdgeInsets)edgeInsets{
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsInWaterfallFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterfallFlowLayout:self];
    }else{
        return UIEdgeInsetsZero;
    }
}

#pragma mark - set up UI

- (void)prepareLayout{
    [super prepareLayout];
    _contentHeight = 0;
    [self.columeHeightArray removeAllObjects];
    for (NSInteger i=0; i<self.columeCount; i++) {
        [self.columeHeightArray addObject:@(self.edgeInsets.top)];
    }
    
    [self.atrributesArrary removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.atrributesArrary addObject:attrs];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.atrributesArrary;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    
    CGFloat attrsWidth = (collectionWidth-self.edgeInsets.left-self.edgeInsets.right-(self.columeCount-1)*self.itemSpace)/self.columeCount;
    
    CGFloat attrsHeight = [self.delegate waterfallFlowLayout:self heightForItemAtIndexPath:indexPath itemWidth:attrsWidth];
    
    CGFloat attrsY = [self.columeHeightArray[0] doubleValue];
    NSInteger minHIndex = 0;
    for (NSInteger i=1; i<self.columeCount; i++) {
        CGFloat tempH = [self.columeHeightArray[i] doubleValue];
        if (attrsY > tempH) {
            attrsY = tempH;
            minHIndex = i;
        }
    }
    if (attrsY != self.edgeInsets.top) {
        attrsY += self.lineSpace;
    }
    
    CGFloat attrsX = self.edgeInsets.left+(attrsWidth+self.itemSpace)*minHIndex;

    attrs.frame = CGRectMake(attrsX, attrsY, attrsWidth, attrsHeight);
    CGFloat attrsMaxH = CGRectGetMaxY(attrs.frame);
    self.columeHeightArray[minHIndex] = @(attrsMaxH);
    
    if (_contentHeight < attrsMaxH) {
        _contentHeight = attrsMaxH;
    }
    return attrs;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, _contentHeight+self.edgeInsets.top);
}
@end
