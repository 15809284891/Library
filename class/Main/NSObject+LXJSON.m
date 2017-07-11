//
//  NSObject+LXJSON.m
//  图书管理
//
//  Created by snow on 2017/1/23.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "NSObject+LXJSON.h"
#import <objc/runtime.h>
#import "DetailModel.h"
@implementation NSObject (LXJSON)
-(instancetype)getJsonData:(NSDictionary *)dic{
    NSDictionary *tempDic = dic[@"Detail"];
    id obj = [[self class] new];
    Class class = self.class;
    unsigned int count;
    Ivar *ivars = class_copyIvarList(class, &count);
    for (int i=0 ; i<count; i++) {
        
        Ivar ivar = ivars[i];
        const char*cName = ivar_getName(ivar);
        //C字符串转化为oc字符串
        NSString *name = [[NSString alloc]initWithUTF8String:cName];
        NSArray*arr = [name componentsSeparatedByString:@"_"];
//        NSLog(@"arr  %@",arr);
        NSString *str = arr[1];
        if (tempDic[str]==nil) {
            continue;
        }
        [obj setValue:tempDic[str] forKey:name];
        
    }
    DetailModel *de = obj;
//    NSLog(@"--------%@",de.Title);
    return obj;
}
@end
