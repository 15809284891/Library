//
//  Problem.h
//  图书管理
//
//  Created by shixihao on 16/7/30.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Problem : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * text;
@property(nonatomic,strong)NSMutableArray *problemArray;
-(void)loadData;
@end
