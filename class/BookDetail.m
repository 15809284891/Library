//
//  BookDetail.m
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "BookDetail.h"
#import "MJExtension.h"
#import "CirculationInfo.h"
#import "ReferBooks.h"
#import "DoubanInfo.h"
@implementation BookDetail
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"BookID":@"ID"
             };
}

@end
