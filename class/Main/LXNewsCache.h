//
//  LXNewsCache.h
//  图书管理
//
//  Created by snow on 2017/1/13.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXNewsCache : NSObject
+(void)save:(NSString *)filename:(NSDictionary *)respondDic;
+(NSDictionary *)readData:(NSString *)fileName;
@end
