//
//  NetworkHandler.h
//  UI15_Block
//
//  Created by lizhongren on 15/5/21.
//  Copyright (c) 2015年 lizhongren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NetworkHandler : NSObject


+ (void)getDataWithURLStr:(NSString *)str completion:(void (^)(id result))block error:(void(^)(id judge))block1;



@end
