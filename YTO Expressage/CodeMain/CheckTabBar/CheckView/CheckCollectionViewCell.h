//
//  CheckCollectionViewCell.h
//  YTO Expressage
//
//  Created by dlios on 15-7-5.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Express.h"
@interface CheckCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *indent;

@property (nonatomic, strong) UILabel *order;

@property (nonatomic, strong) UILabel *time;


@property (nonatomic, strong) UIButton *delet;

- (void)loadeViewAdd: (Express *)express;
@property (nonatomic, strong) Express *expres;


@property (nonatomic, strong) void (^block)(NSIndexPath *indexPatch);


@end
