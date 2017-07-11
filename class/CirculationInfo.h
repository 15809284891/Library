//
//  CirculationInfo.h
//  图书管理
//
//  Created by shixihao on 16/7/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CirculationInfo : NSObject
@property(nonatomic,assign)NSInteger Barcode;
@property(nonatomic,copy)NSString *Date;
@property(nonatomic,copy)NSString *Department;
@property(nonatomic,copy)NSString *Sort;
@property(nonatomic,copy)NSString *Status;

@end
