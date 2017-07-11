//
//  LandModel.h
//  图书管理
//
//  Created by lixue on 16/5/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Landblock)(NSArray *array);
@interface LandModel : NSObject
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString  *session;
@property(nonatomic,strong)NSArray *statusAndsession;
-(void)initUserNameAndPwd:(NSDictionary *)dic;
@end
