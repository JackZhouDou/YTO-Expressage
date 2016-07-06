//
//  LocationViewController.h
//  YTO Expressage
//
//  Created by dlios on 15-7-6.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseViewController.h"

@protocol SearchMapData <NSObject>

@optional

-(void)getYTOArray:(NSArray *)data;




@end



@interface LocationViewController : BaseViewController

@property (nonatomic, assign) id<SearchMapData>deleget;


@end
