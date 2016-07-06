//
//  International.m
//  DDpp
//
//  Created by dlios on 15-6-30.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "International.h"

@implementation International


static NSBundle *bundle = nil;

+ ( NSBundle * )bundle{
    
    return bundle;
    
}


+(void)initUserLanguage{

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    
        if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        NSString *current = [languages objectAtIndex:0];
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化，不加的话不会保存
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}

//获取当前语言方法
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:@"userLanguage"];
    
    return language;
}



//设置语言方法
+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    
    [def synchronize];
}











@end
