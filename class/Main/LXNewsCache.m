//
//  LXNewsCache.m
//  图书管理
//
//  Created by snow on 2017/1/13.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXNewsCache.h"

@implementation LXNewsCache
+(void)save:(NSString *)filename :(NSDictionary *)respondDic{
    //第二种方法
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //还要指定存储文件的文件名称,仍然使用字符串拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:filename];
    NSLog(@"%@",filePath);
    //新建一个数组(作为例子)
    //将数组存储到文件中
    [respondDic writeToFile:filePath atomically:YES];
}
+(NSDictionary *)readData:(NSString *)fileName{
    //获取Documents目录
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //还要指定存储文件的文件名称,仍然使用字符串拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    //使用一个数组来接受数据
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    NSLog(@"%@",dic);
    return dic;
}
@end
