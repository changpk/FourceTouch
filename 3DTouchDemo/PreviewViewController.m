


//
//  PreviewViewController.m
//  3DTouchDemo
//
//  Created by changpengkai on 16/5/25.
//  Copyright © 2016年 changpengkai. All rights reserved.
//

#import "PreviewViewController.h"

@implementation PreviewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--- %s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--- %s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--- %s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--- %s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//预览页面 底部Action Items
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    NSLog(@"--- %s",__func__);

    self.view.frame = CGRectMake(0, 0, 100, 100);
    UIPreviewAction *p1 =[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了分享");
    }];
    
    UIPreviewAction *p2 =[UIPreviewAction actionWithTitle:@"收藏" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了收藏");
    }];
    
    NSArray *actions = @[p1,p2];
    return actions;
}
@end
