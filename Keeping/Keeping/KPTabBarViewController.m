//
//  KPTabBarViewController.m
//  Keeping
//
//  Created by 宋 奎熹 on 2017/1/17.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "KPTabBarViewController.h"
#import "Utilities.h"

@interface KPTabBarViewController ()

@end

@implementation KPTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    self.kpTodayTableViewController = self.viewControllers[0];
    self.kpTaskTableViewController = self.viewControllers[1];
    
    [self.navigationItem setTitle:@"今日"];
    
    //设置底下 item
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    [[self.tabBar.items objectAtIndex:0] setTitle:@"今日"];
    [[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@""]];
    [[self.tabBar.items objectAtIndex:1] setTitle:@"任务"];
    [[self.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@""]];
    [[self.tabBar.items objectAtIndex:2] setTitle:@"统计"];
    [[self.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@""]];
    [[self.tabBar.items objectAtIndex:3] setTitle:@"设置"];
    [[self.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@""]];
    
    NSDictionary *dicTab = @{NSFontAttributeName:[UIFont fontWithName:[Utilities getFont] size:10.0],NSForegroundColorAttributeName: [Utilities getColor]};
    for(UITabBarItem *item in self.tabBar.items){
        [item setTitleTextAttributes:dicTab forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITabBarController Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"%lu", (unsigned long)self.selectedIndex);
    switch (self.selectedIndex) {
        case 0:
        {
            [self.navigationItem setTitle:@"今日"];
            
            self.navigationItem.rightBarButtonItems = nil;
        }
            break;
        case 1:
        {
            [self.navigationItem setTitle:@"任务"];
            
            UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NAV_ADD"] style:UIBarButtonItemStylePlain target:self.kpTaskTableViewController action:@selector(addAction:)];
            self.navigationItem.rightBarButtonItems = @[addItem];
        }
            break;
        case 2:
        {
            [self.navigationItem setTitle:@"统计"];

            self.navigationItem.rightBarButtonItems = nil;
        }
            break;
        case 3:
        {
            [self.navigationItem setTitle:@"设置"];
            
            self.navigationItem.rightBarButtonItems = nil;
        }
            break;
        default:
            break;
    }
}

@end