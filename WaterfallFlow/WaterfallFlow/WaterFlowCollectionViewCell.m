//
//  WaterFlowCollectionViewCell.m
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

#import "WaterFlowCollectionViewCell.h"

@implementation WaterFlowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _textLab = [[UILabel alloc] initWithFrame:frame];
        [self.contentView addSubview:_textLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _textLab.frame = self.bounds;
}

@end
