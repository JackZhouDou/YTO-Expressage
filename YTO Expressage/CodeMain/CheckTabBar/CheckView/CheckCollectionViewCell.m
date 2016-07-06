//
//  CheckCollectionViewCell.m
//  YTO Expressage
//
//  Created by dlios on 15-7-5.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "CheckCollectionViewCell.h"
#import "CoerDateModel.h"
@interface CheckCollectionViewCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end


@implementation CheckCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.indent = [[UILabel alloc]init];
        self.indent.numberOfLines = 0;
        self.indent.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.indent];
        
        
        self.time = [[UILabel alloc]init];
        self.time.textAlignment = NSTextAlignmentCenter;
        self.time.font = [UIFont systemFontOfSize:16];
        self.time.numberOfLines = 0;
        [self.contentView addSubview:self.time];
        
        
        
        self.order = [[UILabel alloc]init];
        self.order.textAlignment = NSTextAlignmentCenter;
        self.order.font = [UIFont boldSystemFontOfSize:16];

        [self.contentView addSubview:self.order];
        
        
        
        self.delet = [UIButton buttonWithType:UIButtonTypeSystem];
        
        self.delet.hidden = YES;
        
        [self.delet setBackgroundImage:[UIImage imageNamed:@"delet"] forState:UIControlStateNormal];
        
        [self.delet addTarget:self action:@selector(deletModel:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.delet];
        
    
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongGesture:)];
        
        [self.contentView addGestureRecognizer:longGesture];
        
        longGesture.minimumPressDuration = 0.8f;
        
        
        
    }
    return self;
}



- (void)LongGesture:(UILongPressGestureRecognizer *)longpress {
    
    
    if (longpress.state == UIGestureRecognizerStateBegan) {
        
//        NSLog(@"hua");
        self.delet.hidden = NO;
        
    } else if (longpress.state == UIGestureRecognizerStateEnded){
        
        
        
        
        
    }
    
    
    
    
    
    
}


- (void)loadeViewAdd:(Express *)express {
    
    if (_expres != express) {
        
        
        self.expres = express;
        
        
        
        
    }
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (user) {
//        NSLog(@"dsfgs");
        if ([[user objectForKey:@"languge"] isEqualToString:@"chaince"]) {
            
        
        self.order.text = [NSString stringWithFormat:@"运单号 %@", express.indent];
        
        self.indent.text = [NSString stringWithFormat:@"备注: %@",express.remark];
        
        self.time.text = [NSString stringWithFormat:@"发货时间:%@", express.time];
        } else  {
        
        self.order.text = [NSString stringWithFormat:@"The awb %@", express.indent];
        NSLog(@"safsafsa");
        self.indent.text = [NSString stringWithFormat:@"Note: %@",express.remark];
        
        self.time.text = [NSString stringWithFormat:@"Time:%@", express.time];
    }
    
    
   
    
    
    }
    

}






- (void)deletModel:(UIButton *)action {
    
    CoerDateModel *coer = [[CoerDateModel alloc]initCoreDate];
    
    [coer deleteModel:self.expres];
    
    self.block(self.indexPath);
    
}




- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    
    CGFloat width = layoutAttributes.frame.size.width / 10;
    
    CGFloat height = layoutAttributes.frame.size.height / 5;
    
    self.order.frame = CGRectMake(0, 0, 9* width, 1.2 * height);
    
    self.indent.frame = CGRectMake(0, 2.5 * height, width * 10, 2.5 * height);
    
    self.delet.frame = CGRectMake(9 * width, 0, width,  width);
    self.delet.clipsToBounds = YES;
    self.delet.layer.cornerRadius = width / 2;

    
    self.time.frame = CGRectMake(0, 1.4 * height, width * 10,  height);
    
    self.indexPath = layoutAttributes.indexPath;

    
    
}

@end
