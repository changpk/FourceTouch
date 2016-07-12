//
//  ViewController.m
//  3DTouchDemo
//
//  Created by changpengkai on 16/5/25.
//  Copyright © 2016年 changpengkai. All rights reserved.
//

#import "ViewController.h"
#import "PreviewViewController.h"

@interface ViewController ()<UIViewControllerPreviewingDelegate>
{
    id<UIViewControllerPreviewing> _previewingContext;
}
- (IBAction)peekAndPopAction:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
}

- (IBAction)peekAndPopAction:(UIButton *)sender {
    
    if (![self forceTouchisAailable]) {
        return;
    }
    
    if ([sender.currentTitle isEqualToString:@"peekAction"]) {
       _previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];

        [sender setTitle:@"popAction" forState:UIControlStateNormal];

    }else if ([sender.currentTitle isEqualToString:@"popAction"]) {
        [self unregisterForPreviewingWithContext:_previewingContext];
        [sender setTitle:@"peekAction" forState:UIControlStateNormal];
    }
    
}

#pragma mark - UIViewControllerPreviewingDelegate

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    NSLog(@"location is %@",NSStringFromCGPoint(location));
    
    previewingContext.sourceRect = CGRectMake(100, 100, 180, 180);
//    NSLog(@"-- sourceView is %@",previewingContext.sourceView);
    

    PreviewViewController *previewController = [[PreviewViewController alloc]init];
    
    UIImageView *fengjinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    fengjinImageView.image = [UIImage imageNamed:@"1.jpg"];
    fengjinImageView.center = previewController.view.center;
    [previewController.view addSubview:fengjinImageView];
    
    return previewController;
    
//    // 判断是否应该触发 peek
//    if (CGRectContainsPoint(CGRectMake(0, 0, 100, 100), location)) {
//        
//        // 指定显示的高亮区域
//        previewingContext.sourceRect = CGRectMake(100, 100, 180, 180);
//        NSLog(@"-- sourceView is %@",previewingContext.sourceView);
//        
//        PreviewViewController *previewController = [[PreviewViewController alloc]init];
//        return nil;
//    }
    
    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    [viewControllerToCommit.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    viewControllerToCommit.view.backgroundColor = [UIColor cyanColor];
    [self presentViewController:viewControllerToCommit animated:YES completion:NULL];
}

// 展示当前环境的特征集合:UIUserInterfaceIdiom、displayScale、horizontalSizeClass、verticalSizeClass、UIForceTouchCapability
- (void)displayUITraitCollection {
    
    // 3Dtouch是在9.0以后出现的
    if (!([UIDevice currentDevice].systemVersion.floatValue >= 9.0)) {
        return ;
    }
    UITraitCollection *traitCollection = self.traitCollection;
    NSLog(@"traitCollection is %@",traitCollection);
}

// 遵守协议的当前对象（UIScreen, UIWindow, UIViewController, UIPresentationController, and UIView）的特性环境第一次展示和改变的时候，发送这个通知(但是3D touch 只能去设置->通用->辅助功能->3D Touch进行开启和关闭，此时不会触发因为程序已经在后台休眠了 😄)
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    NSLog(@"previousTraitCollection is %@,\ncurrentTraitCollection is %@",previousTraitCollection,self.traitCollection);
}

// 3Dtouch是否开启
- (BOOL)forceTouchisAailable {
    
    // 3Dtouch是在9.0以后出现的
    if (!([UIDevice currentDevice].systemVersion.floatValue >= 9.0)) {
        return NO;
    }
    [self displayUITraitCollection];
    return self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
}

@end
