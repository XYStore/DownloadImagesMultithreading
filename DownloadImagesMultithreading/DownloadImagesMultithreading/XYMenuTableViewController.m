//
//  XYMenuTableViewController.m
//  DownloadImagesMultithreading
//
//  Created by 严必庆 on 2017/11/21.
//  Copyright © 2017年 XYStore. All rights reserved.
//

#import "XYMenuTableViewController.h"

@interface XYMenuTableViewController ()

@end

@implementation XYMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"任务是同步网络请求";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"任务是异步网络请求";
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *syncVC = [story instantiateViewControllerWithIdentifier:@"syncRequest"];
        syncVC.title = @"同步任务";
        [self.navigationController pushViewController:syncVC animated:true];
        
    }else if (indexPath.row == 1) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *asyncVC = [story instantiateViewControllerWithIdentifier:@"asyncRequest"];
        asyncVC.title = @"异步任务";
        [self.navigationController pushViewController:asyncVC animated:true];

    }
    
}
@end
