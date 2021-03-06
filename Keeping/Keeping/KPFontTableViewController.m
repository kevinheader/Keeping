//
//  KPFontTableViewController.m
//  Keeping
//
//  Created by 宋 奎熹 on 2017/1/23.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "KPFontTableViewController.h"
#import "Utilities.h"
#import "KPNavigationViewController.h"
#import "KPTabBarViewController.h"
#import "KPTaskTableViewCell.h"
#import "KPTodayTableViewCell.h"
#import "HYCircleProgressView.h"
#import "Task.h"
#import "KPTimeView.h"
#import "UIViewController+Extensions.h"
#import "MGSwipeTableCell.h"

#define GROUP_ID @"group.com.krayc.keeping"

@interface KPFontTableViewController()<MGSwipeTableCellDelegate>

@end

@implementation KPFontTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"字体"];
    
    [self.sizeControl setTintColor:[Utilities getColor]];
    
    [self.sizeControl setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults] integerForKey:@"fontSize"]];
    [self.sizeControl addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChanged{
    [self vibrateWithStyle:UIImpactFeedbackStyleLight];
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.sizeControl.selectedSegmentIndex forKey:@"fontSize"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [@[@(1), @(2)][section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        Task *t = [Task new];
        
        t.name = @"展示任务";
        t.reminderDays = @[@(1),@(3),@(5),@(7)];
        t.image = NULL;
        t.link = NULL;
        t.appScheme = NULL;
        t.memo = NULL;
        t.reminderTime = [NSDate date];
        t.type = 3;
        
        switch (indexPath.row) {
            case 0:
            {
                static NSString *cellIdentifier = @"KPTodayTableViewCell";
                UINib *nib = [UINib nibWithNibName:@"KPTodayTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                KPTodayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
                
                [cell setIsSelected:NO];
                
                [cell setFont];
                
                cell.delegate = self;
                
                [cell.taskNameLabel setText:t.name];
                
                [cell.moreButton setHidden:YES];
                [cell.typeImg setHidden:NO];
                [cell.appImg setHidden:YES];
                [cell.linkImg setHidden:YES];
                [cell.memoImg setHidden:YES];
                [cell.imageImg setHidden:YES];
                
                UIImage *img = [UIImage imageNamed:@"CIRCLE_FULL"];
                img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                cell.typeImg.tintColor = [Utilities getTypeColorArr][t.type - 1];
                [cell.typeImg setImage:img];
                
                [cell.reminderTimeView setTime:t.reminderTime];
                [cell.reminderTimeView setHidden:NO];
                
                return cell;
            }
                break;
            case 1:
            {
                static NSString *cellIdentifier = @"KPTaskTableViewCell";
                UINib *nib = [UINib nibWithNibName:@"KPTaskTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                KPTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
                
                [cell setFont];
                
                cell.delegate = self;
                
                [cell.nameLabel setText:t.name];
                
                [cell.weekdayView selectWeekdaysInArray:[NSMutableArray arrayWithArray:t.reminderDays]];
                [cell.weekdayView setIsAllSelected:NO];
                [cell.weekdayView setUserInteractionEnabled:NO];
                
                UIImage *img = [UIImage imageNamed:@"CIRCLE_FULL"];
                img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                cell.typeImg.tintColor = [Utilities getTypeColorArr][t.type - 1];
                [cell.typeImg setImage:img];
                
                [cell.progressView setProgress:(arc4random() % 101) / 100.0 animated:NO];
                
                return cell;
            }
                break;
            default:
                return [super tableView:tableView cellForRowAtIndexPath:indexPath];
        }
        
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        return 70;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell canSwipe:(MGSwipeDirection)direction fromPoint:(CGPoint)point{
    return NO;
}

@end
