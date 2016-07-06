//
//  NetworkHandler.m
//  UI15_Block
//
//  Created by lizhongren on 15/5/21.
//  Copyright (c) 2015年 lizhongren. All rights reserved.
//

#import "NetworkHandler.h"

@implementation NetworkHandler


+ (void)getDataWithURLStr:(NSString *)str completion:(void (^)(id result))block error:(void(^)(id judge))block1
{
    // get请求方式
    
    NSString *tempStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:tempStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    
    // 连接服务器
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        if (connectionError == nil) {
            
      
        // 1. 创建一个文件路径
        
        
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        
        
        // 2. 第二种: hash, 利用对象的哈希值
        // 哈希值: 地址相同, hash一定相同
        
        NSUInteger hash = [str hash];
        NSString *dataPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu.data", (unsigned long)hash]];
        
        
        NSData *resultData = nil;
        if (data != nil) {
            // 在有网的时候, 将数据写入本地
            [data writeToFile:dataPath atomically:YES];
            resultData = data;
        } else {
            // 没有网的时候读取本地数据
            resultData = [NSData dataWithContentsOfFile:dataPath];
        }
        
        // 判断有没有数据
        if (resultData == nil) {
            
            NSLog(@"没有网络");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络不好请重新加载" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
         
        } else {
            // 有数据就解析数据, 用block返回
            id result = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
            // result就是最后想要得到的结果, 使用block进行进一步数据操作.
            block(result);
        }
        
        } else {
            
            block1(connectionError);
            
            
        }
        
        
        
    }];
    
}





@end
