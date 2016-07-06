//
//  CoerDateModel.h
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Express;
@interface CoerDateModel : NSObject

- (instancetype)initCoreDate;
- (void)addModel:(NSString *)time indent:(NSString *)indent remark:(NSString *)remark;

- (NSArray *)selectModel;



- (void)deleteModel:(Express *)exprees;

- (void) deleteAll;

@end
