//
//  personModel.h
//  图书管理
//
//  Created by lixue on 16/5/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface personModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *Department;
-(void)initPersonInfo:(NSDictionary *)dic;
@end
