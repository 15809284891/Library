//
//  SearchType.h
//  图书管理
//
//  Created by snow on 2017/5/20.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchType : NSObject
@property(nonatomic,copy)NSArray *wordTypes;
@property(nonatomic,copy)NSArray *wordTypeindexs;
@property(nonatomic,copy)NSArray *matchMethods;
@property(nonatomic,copy)NSArray *matchMethodindexs;
@property(nonatomic,copy)NSArray *recordTypes;
@property(nonatomic,copy)NSArray *recordTypeindexs;
@property(nonatomic,copy)NSArray *orderscArray;
@property(nonatomic,copy)NSArray *orderscArrayindexs;
@property(nonatomic,copy)NSArray *orderbyArray;
@property(nonatomic,copy)NSArray *orderbyArrayindexs;
@property(nonatomic,copy)NSDictionary *titles_types;
@property (nonatomic,copy)NSArray *titles;
@property (nonatomic,strong)NSMutableDictionary *paramasDic;
+(SearchType *)shareInstance;
@end
