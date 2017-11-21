//
//  Request.m
//  DownloadImagesMultithreading
//
//  Created by 严必庆 on 2017/11/21.
//  Copyright © 2017年 XYStore. All rights reserved.
//

#import "Request.h"
static Request *singleton = nil;
@implementation Request

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (singleton == nil) {
            singleton = [[[self class] alloc] init];
        }
    });
    return singleton;
}

-(NSString *)mainURLString {
    return @"http://httpbin.org/";
}

-(void)getWithURLString:(NSString *)urlString success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSURLSession *session = [NSURLSession sharedSession];
    //拼接url
    NSString *completeUrlString = [[self mainURLString] stringByAppendingString:urlString];
    NSURL *url = [NSURL URLWithString:completeUrlString];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error != nil) {
            NSLog(@"%@",error);
            failure(error);
        } else {
            NSError *err = nil;
            id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            if (err != nil) {
                failure(err);
            }else {
                success(dict);
            }
        }
        
   }];
    [task resume];
}

@end
