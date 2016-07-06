//
//  Express.h
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Express : NSManagedObject

@property (nonatomic, retain) NSString * indent;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * remark;

@end
