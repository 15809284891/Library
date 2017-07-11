//
//  DetailModel.m
//  图书管理
//
//  Created by lixue on 16/4/23.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "DetailModel.h"
#import <objc/runtime.h>
#import "NSObject+LXJSON.h"
@interface DetailModel()
@property (nonatomic,copy)NSString * ETag;
@end
@implementation DetailModel{
    CGFloat _titleHeight;
}
+(DetailModel *)shareInstance{
    static DetailModel *_model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _model = [[DetailModel alloc]init];
    });
    return _model;

}
-(CGFloat)titleHeight{
    CGSize size1 = CGSizeMake(250, MAXFLOAT);
    CGSize caculateTitleSize = [self.Title boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:
                                @{NSFontAttributeName:[UIFont systemFontOfSize:20.0]} context:nil].size;
    
    return caculateTitleSize.height ;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    //利用runtime获取实例变量的列表
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        //取出i位置对应的实例变量
        Ivar ivar = ivars[i];
        //查看实例变量的名字
        const char *name = ivar_getName(ivar);
        //C语言字符串转化为NSStrng
        NSString *nameStr = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //利用kvc取出属性对应的值
        id value = [self valueForKey:nameStr];
        //归档
        [aCoder encodeObject:value forKey:nameStr];
    }
    //释放C语言中copy出来的要进行释放
    free(ivars);
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}
//如果本地缓存为最新，则使用本地缓存，如果服务器已经更新或者本地无缓存则从服务器开始请求
//http只对get做缓存
-(void)getDetailModelDataWithType:(NSString *)type withID:(NSString*)ID Block:(void (^)(DetailModel *, NSError *))block{
    
    //步骤
    /*请求是可变的，缓存策略要每次都从服务器加载
     *每次得到响应时，需要记住etag
     *下载发送请求的同时，将etag一起发送给服务器
     */
    NSString *urlStr = [NSString urlStringWithpath:NEWS_DETAIL paramas:@{@"type":type,@"format":@"html",@"id":ID}];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    
    NSString *etagPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [etagPath stringByAppendingPathComponent:@"etag.Archiver"];
    __block NSMutableDictionary *eTagDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    self.ETag = eTagDic[ID]?eTagDic[ID]:nil;
    if (self.ETag.length>0) {
        //Etag有值，则发送给服务器,进行比较
        [request setValue:self.ETag forHTTPHeaderField:@"If-None-Match"];
    }
    [[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            //没有更新
        if(httpResponse.statusCode == 304){
                  //根据请求获取到被缓存的响应
                  NSCachedURLResponse *cacheResponde = [[NSURLCache  sharedURLCache] cachedResponseForRequest:request];
                  //拿到缓存的数据 
                  data = cacheResponde .data;
              }
        //重新给Etag赋值
        else if(httpResponse.statusCode == 200){
                  self.ETag = httpResponse.allHeaderFields[@"Etag"];
//                  NSLog(@"%@",self.ETag);
                  //缓存数据
                  NSURLCache *cache = [NSURLCache sharedURLCache];
                  [cache storeCachedResponse:[[NSCachedURLResponse alloc]initWithResponse:response data:data] forRequest:request];
                  
                  if (!eTagDic) {
                      eTagDic = [@{ID:self.ETag} mutableCopy];
                  }
                  else{
                      eTagDic[ID] = self.ETag;
                  }
                  [NSKeyedArchiver archiveRootObject:eTagDic toFile:path];
              }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
        DetailModel *model = (DetailModel*)[[DetailModel shareInstance]getJsonData:dic];
        block(model,nil);
        
    }] resume];
}
@end
