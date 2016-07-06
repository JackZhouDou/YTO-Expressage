//
//  NearbyTabelViewController.h
//  YTO Expressage
//
//  Created by dlios on 15-7-7.
//  Copyright (c) 2015年 douDou.office. All rights reserved.
//

#import "BaseViewController.h"
#import "NearbView.h"

#import "POIAnnotation.h"
@class MapModel;

@interface NearbyTabelViewController : BaseViewController

@property (nonatomic, strong) AMapPOI *poi;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) MapModel *model;
@end
