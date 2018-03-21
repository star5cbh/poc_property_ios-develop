//
//  BaseNavigationController.m
//  Webet
//
//  Created by chenbaohui on 2016/12/14.
//  Copyright © 2016年 peersafe_webet. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, getter=isPushing) BOOL pushing;
@property(nonatomic,weak) UIViewController* currentShowVC;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.shadowImage = [UIImage new];
    self.delegate = self;

    self.navigationController.navigationBar.translucent = NO;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    BaseNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController); //the most important
    }
    return YES;
}

//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (self.pushing == YES) {
//        DLog(@"被拦截");
//        return;
//    } else {
//        DLog(@"push");
//        self.pushing = YES;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}


//#pragma mark - UINavigationControllerDelegate
//-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    self.pushing = NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
