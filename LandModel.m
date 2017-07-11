//
//  LandModel.m
//  图书管理
//
//  Created by lixue on 16/5/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LandModel.h"

@implementation LandModel
+(LandModel *)model{
    static dispatch_once_t predicate;
    static  LandModel *model;
    dispatch_once(&predicate,^{
        model = [[LandModel alloc]init];
    });
    return model;
}
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)initUserNameAndPwd:(NSDictionary *)dic{
//    NSLog(@" sssssss  :%@",dic);
        self.status = [dic objectForKey:@"Result"];
        self.session = [dic objectForKey:@"Detail"];
}
@end
