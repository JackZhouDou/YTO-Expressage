//
//  MapModel.h
//  YTO Expressage
//
//  Created by dlios on 15-7-6.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseModel.h"

@interface MapModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;

@property(nonatomic, assign) float latitude;



@property (nonatomic, assign) float longitude;

@property (nonatomic, copy) NSString *tell;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, copy) NSString *district;

@end
