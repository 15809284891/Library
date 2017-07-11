//
//  personModel.m
//  图书管理
//
//  Created by lixue on 16/5/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "personModel.h"


@implementation personModel
-(id)init{
    self =[ super init];
    if (self) {
    }
    return self;
}
-(void)initPersonInfo:(NSDictionary *)dic{
        NSDictionary *dicData = dic[@"Detail"];
        self.ID = dicData[@"ID"];
        self.Name=dicData[@"Name"];
        self.Department = dicData[@"Department"];
}
@end
