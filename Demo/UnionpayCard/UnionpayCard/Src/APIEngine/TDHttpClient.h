//
//  TDHttpManager.h
//  UnionpayCard
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TDBlock)(NSURLSessionDataTask *task, id responseObject, NSError* anError);

typedef void(^TDCompletionBlock)(id responseObject);


@interface TDHttpClient : AFHTTPSessionManager


+ (TDHttpClient *)sharedClient;


- (void)processCommand:(TDHttpCommand * ) command callback:(TDBlock)aCallback;



@end
