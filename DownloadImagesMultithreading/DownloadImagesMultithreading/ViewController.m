

#import "ViewController.h"
#import <FTIndicator/FTIndicator.h>
typedef void(^CompleteHandler)(BOOL isSuccessful);
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;
//@property (nonatomic, copy) CompleteHandler completeHandler;

@end

@implementation ViewController


/**
 开始下载
 @param sender UIButton
 */
- (IBAction)startLoad:(id)sender {
    [FTIndicator showProgressWithMessage:@"开始下载"];
    [self loadImagesWithCompleteHandler:^(BOOL isSuccessful) {
        if (isSuccessful) {
            NSLog(@"所有图片下载完成");
            
            //            [FTIndicator dismissProgress];
            
            //            [FTIndicator showSuccessWithMessage:@"下载成功"];
            
            [FTIndicator dismissProgress];
            [FTIndicator showNotificationWithTitle:@"通知" message:@"下载成功"];
            
            [self composeImages];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(UIImage *)imageWithURLString:(NSString *)urlString{
    //    [NSThread sleepForTimeInterval:arc4random() % 4];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    return [UIImage imageWithData:data];
}

-(void)loadImagesWithCompleteHandler:(CompleteHandler)completeHandler {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    NSLog(@"self.image1开始下载");
    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:2.0];
        self.image1 = [self imageWithURLString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3505995965,2781827203&fm=27&gp=0.jpg"];
        NSLog(@"self.image1下载完成,%@",self.image1);
    });
    
    NSLog(@"self.image2开始下载");
    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:2.0];
        self.image2 = [self imageWithURLString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3505995965,2781827203&fm=27&gp=0.jpg"];
        NSLog(@"self.image2下载完成,%@",self.image2);
        
    });
    
    NSLog(@"self.image3开始下载");
    dispatch_group_async(group, queue, ^{
//        [NSThread sleepForTimeInterval:2.0];
        self.image3 = [self imageWithURLString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1573503644,1731902687&fm=27&gp=0.jpg"];
        NSLog(@"self.image3下载完成,%@",self.image3);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        
        completeHandler(YES);
    });
    
    
    //    dispatch_sync(queue, ^{
    //        [NSThread sleepForTimeInterval:2.0];
    //        self.image1 = [self imageWithURLString:@"http://pic4.nipic.com/20091217/3885730_124701000519_2.jpg"];
    //        NSLog(@"self.image1下载完成,%@",self.image1);
    //    });
    //    dispatch_sync(queue, ^{
    //        [NSThread sleepForTimeInterval:2.0];
    //        self.image2 = [self imageWithURLString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3505995965,2781827203&fm=27&gp=0.jpg"];
    //        NSLog(@"self.image2下载完成,%@",self.image2);
    //    });
    //    dispatch_sync(queue, ^{
    //        [NSThread sleepForTimeInterval:2.0];
    //        self.image3 = [self imageWithURLString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1573503644,1731902687&fm=27&gp=0.jpg"];
    //        NSLog(@"self.image3下载完成,%@",self.image3);
    //    });
    //
    //    completeHandler(YES);
    
}

-(void)composeImages {
    //加载所有png
    CGImageRef imgRef1 = self.image2.CGImage;
    CGFloat w1 = CGImageGetWidth(imgRef1);
    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    CGImageRef imgRef2 = self.image2.CGImage;
    CGFloat w2 = CGImageGetWidth(imgRef2);
    CGFloat h2 = CGImageGetHeight(imgRef2);
    
    CGImageRef imgRef3 = self.image3.CGImage;
    CGFloat w3 = CGImageGetWidth(imgRef3);
    CGFloat h3 = CGImageGetHeight(imgRef3);
    
    //以image1 为底图
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    
    [self.image1 drawInRect: CGRectMake(0, 0, w1, h1)];
    [self.image2 drawInRect: CGRectMake(100, 100, w2 * 0.3, h2 * 0.3)];
    [self.image3 drawInRect: CGRectMake(300, 200, w3 * 0.3, h3 * 0.3)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    //
    UIGraphicsEndImageContext();
    
    self.imageView.image = resultImage;
    
    //释放内存
    //    CGImageRelease(imgRef1);
    CGImageRelease(imgRef2);
    CGImageRelease(imgRef3);
    
    
}


@end
