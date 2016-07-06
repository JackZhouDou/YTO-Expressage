//
//  BaseView.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        CGFloat width = frame.size.width / 10;
        CGFloat height = frame.size.height;
        
        
        self.bit = [[UIView alloc]initWithFrame:CGRectMake(0,  3 * height / 4, height / 4, height / 4)];
//        self.bit.center = CGPointMake(height / 8, height / 2);
        self.bit.layer.cornerRadius = height / 8;
        self.bit.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bit];
        
        
        
        self.bit1 = [[UIView alloc]initWithFrame:CGRectMake(0.5 * height , 3 * height / 4, height / 4, height / 4)];
//        self.bit1.center = CGPointMake(0.625 * height, height / 2);
        
        self.bit1.layer.cornerRadius = height / 8;
        self.bit1.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bit1];
        
        
        self.bit2 = [[UIView alloc]initWithFrame:CGRectMake(height, 3 * height / 4, height / 4 , height / 4)];
//        self.bit2.center = CGPointMake(0.875 * height, height / 2);
        self.bit2.layer.cornerRadius = height / 8;
        self.bit2.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bit2];
        
        self.titl = [[UILabel alloc]initWithFrame:CGRectMake(1.5 *  height, 0, width * 10 - 1.5 * height, height)];
        self.titl.font = [UIFont boldSystemFontOfSize:26];
        self.titl.tintColor = [UIColor brownColor];
        self.titl.text = @"圆通加载中";
        [self addSubview:self.titl];
        
        
        
        
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
