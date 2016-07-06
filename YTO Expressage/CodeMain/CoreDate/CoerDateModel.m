//
//  CoerDateModel.m
//  YTO Expressage
//
//  Created by dlios on 15-7-2.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "CoerDateModel.h"
#import "CoerDate.h"
#import "Express.h"

@interface CoerDateModel ()
@property (nonatomic, strong ) CoerDate *manager;


@end

@implementation CoerDateModel


- (instancetype)initCoreDate {
    
    self.manager = [CoerDate defaultManger];
    NSLog(@"%@", [self. manager applicationDocumentsDirectory]);
    
    return self;
    
}

- (void)addModel:(NSString *)time indent:(NSString *)indent remark:(NSString *)remark {
    
    Express *model = [NSEntityDescription insertNewObjectForEntityForName:@"Express" inManagedObjectContext:self.manager.managedObjectContext];
    model.time = time;
    model.indent = indent;
    model.remark = remark;
    [self.manager saveContext];
    
    
    
}


- (void) deleteAll {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Express" inManagedObjectContext:self.manager.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",minf];
//    [fetchRequest setPredicate:predicate];
//    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.manager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
    
//    }
    
    for (Express *express in fetchedObjects) {
        
        
        [self.manager.managedObjectContext deleteObject:express];
        
    }
    
    [self.manager saveContext];
    
    
}

- (NSArray *)selectModel {
    

    
    
    
    
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Express" inManagedObjectContext:self.manager.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS 'o'"];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"indent"
//                                                                   ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.manager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    if (fetchedObjects == nil) {
        NSLog(@"error:%@", error);
    }

    for (Express *pr in fetchedObjects) {
        
        NSLog(@"%@", pr.indent);
        
        
    }
    
    
    return fetchedObjects;
    

}

- (void)deleteModel:(Express *)exprees {
    
    
    
    
    [self.manager.managedObjectContext deleteObject:exprees];
    
    [self.manager saveContext];
    
    
}





@end
