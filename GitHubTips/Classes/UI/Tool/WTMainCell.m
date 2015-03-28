//
//  WTMainCell.m
//  HealthTip
//
//  Created by Yorke on 15/3/1.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "WTMainCell.h"

@interface WTMainCell (){
}

@end

@implementation WTMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setContent:(id)content{
    self.textLabel.text = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
