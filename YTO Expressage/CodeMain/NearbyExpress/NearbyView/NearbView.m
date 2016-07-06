//
//  NearbView.m
//  YTO Expressage
//
//  Created by dlios on 15-7-7.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "NearbView.h"

@implementation NearbView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemTitl = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width / 6,  frame.size.height)];
        
        [self addSubview:self.itemTitl];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 5, 0, 4 * frame.size.width / 5, frame.size.height)];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        
        [self addSubview:self.titleLabel];
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
