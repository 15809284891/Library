//
//  CuustomHttpProtocol.m
//  图书管理
//
//  Created by snow on 2017/5/16.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "CuustomHttpProtocol.h"

@implementation CuustomHttpProtocol
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}
-(instancetype)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client{
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}
@end
