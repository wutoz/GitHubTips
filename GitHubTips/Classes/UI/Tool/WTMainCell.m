//
//  WTMainCell.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTMainCell.h"

@interface WTMainCell (){
    UILabel *_titleLab;
}

@end

@implementation WTMainCell

- (void)awakeFromNib {
    // Initialization code
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 50)];
    [self.contentView addSubview:_titleLab];
}

- (void)setContent:(id)content{
    _titleLab.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
