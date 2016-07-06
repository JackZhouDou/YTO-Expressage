//
//  CoerDate.h
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoerDate : NSObject

//数据管理器
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模拟器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

//连接器
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存器件
- (void)saveContext;

//获取本地路径
- (NSURL *)applicationDocumentsDirectory;

+ (CoerDate *)defaultManger;


@end
