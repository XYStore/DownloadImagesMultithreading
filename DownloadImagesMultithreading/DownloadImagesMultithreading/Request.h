//
//  Request.h
//  DownloadImagesMultithreading
//
//  Created by 严必庆 on 2017/11/21.
//  Copyright © 2017年 XYStore. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void(^SuccessBlock)(id obj);
typedef  void(^FailureBlock)(NSError *error);
@interface Request : NSObject
+(instancetype)sharedInstance;

-(NSString *)mainURLString;

-(void)getWithURLString:(NSString *)urlString success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
