//
//  MapStringData.h
//  YTO Expressage
//
//  Created by dlios on 15-7-9.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MapStringData : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *context;

@property (nonatomic, assign) CGFloat lat2;

@property (nonatomic, assign) CGFloat lng2;

@end
