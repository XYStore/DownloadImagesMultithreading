//
//  XYAsyncRequestVC.m
//  DownloadImagesMultithreading
//
//  Created by 严必庆 on 2017/11/21.
//  Copyright © 2017年 XYStore. All rights reserved.
//

#import "XYAsyncRequestVC.h"
#import "Request.h"
@interface XYAsyncRequestVC ()

@end

@implementation XYAsyncRequestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)start:(id)sender {
    [self loadAsyncRequest];
}

//group里操作是异步
-(void)loadAsyncRequest {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    [NSThread sleepForTimeInterval:2.0];
    
    dispatch_group_enter(group);
    NSLog(@"请求开始");
    
    
    //添加异步任务
    NSLog(@"1号请求开始%@",[NSThread currentThread]);
    dispatch_group_async(group, queue, ^{
        NSLog(@"1号请求block回调%@",[NSThread currentThread]);
        [Request.sharedInstance getWithURLString:@"/delay/11" success:^(id obj) {
            NSLog(@"1号请求完成%@",[NSThread currentThread]);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
        }];
    });
    
//    [NSThread sleepForTimeInterval:2.0];
    
    dispatch_group_enter(group);
    
    NSLog(@"2号请求开始%@",[NSThread currentThread]);
    
    //添加异步任务
    dispatch_group_async(group, queue, ^{
        NSLog(@"2号请求block回调%@",[NSThread currentThread]);
        [Request.sharedInstance getWithURLString:@"/delay/11" success:^(id obj) {
            NSLog(@"2号请求完成%@",[NSThread currentThread]);
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            
        }];
    });
    
//    [NSThread sleepForTimeInterval:2.0];
    
    dispatch_group_enter(group);
    
    //添加异步任务
    NSLog(@"3号请求开始%@",[NSThread currentThread]);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"2号请求block回调%@",[NSThread currentThread]);
        [Request.sharedInstance getWithURLString:@"/delay/11" success:^(id obj) {
            dispatch_group_leave(group);
            NSLog(@"2号请求完成%@",[NSThread currentThread]);
        } failure:^(NSError *error) {
            
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSThread currentThread]);
            NSLog(@"所有网络请求完成");
        });
    });
    NSLog(@"--------------");
    
}


@end
