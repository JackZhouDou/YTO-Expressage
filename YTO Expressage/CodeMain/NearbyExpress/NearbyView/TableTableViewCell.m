//
//  TableTableViewCell.m
//  YTO Expressage
//
//  Created by dlios on 15-7-8.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "TableTableViewCell.h"

@implementation TableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.name = [[UILabel alloc]init];
        [self.contentView addSubview:self.name];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.font = [UIFont boldSystemFontOfSize:22];
        
        
        
        self.address = [[UILabel alloc]init];
        [self.contentView addSubview:self.address];
        
        
        self.image = [[UIImageView alloc]init];
        self.image.image = [UIImage imageNamed:@"2222223"];
        [self.contentView addSubview:self.image];
        
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.contentView.bounds.size.width / 10;
    CGFloat height = self.contentView.bounds.size.height ;
    
    self.image.frame = CGRectMake(width, 5, width, width);
    self.name.frame = CGRectMake(2 * width, 5, 8 * width, width);
    
    
    self.address.frame = CGRectMake(width / 2, 1.3 * width, 9 * width, height - 1.5 * width);
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
