//
//  TrackTableViewCell.m
//  YTO Expressage
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "TrackTableViewCell.h"
#import "CheckViev.h"
@implementation TrackTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.time = [[UILabel alloc]init];
        self.time.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.time];
        
        
        self.address = [[UILabel alloc]init];
        self.address.numberOfLines = 0;
        
        [self.contentView addSubview:self.address];
        
        
//        self.tiemView = [[UIView alloc]init];
////        self.tiemView.hidden = YES;
//        self.tiemView.backgroundColor = [UIColor blackColor];
//    
//        [self.contentView addSubview:self.tiemView];
        
        self.imagebig = [[UIImageView alloc]init];
        self.imagebig.clipsToBounds = YES;
        [self.contentView addSubview:self.imagebig];
        
        
        
        
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    CGFloat width = self.contentView.bounds.size.width / 10;
    CGFloat height = self.contentView.bounds.size.height / 10;
    
    
    self.time.frame = CGRectMake(width * 1.5, 5, 8.5 * width, 2 * height);
    self.address.frame = CGRectMake(width * 1.5, 3 * height, 8.5 * width, 7 * height);
//    self.tiemView.frame = CGRectMake(0.8 * width, 0, 3, height * 10);
    
    self.imagebig.frame = CGRectMake(0.5 * width, 0, 0.6 * width, 0.6 * width);
    self.imagebig.layer.cornerRadius = 0.3 * width;
    self.imagebig.center = CGPointMake(0.8 * width, 5 * height);
    
    
    
    
    
     
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
