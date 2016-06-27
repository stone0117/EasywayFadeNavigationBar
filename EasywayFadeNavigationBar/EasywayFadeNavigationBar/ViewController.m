//
//  ViewController.m
//  EasywayFadeNavigationBar
//
//  Created by stone on 16/6/27.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "UINavigationController+BarAlpha.h"
#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /** 添加tableHeaderView */
    UIImage * image = [UIImage imageNamed:@"2015092107"];
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = (image.size.height / image.size.width) * width - 64;
    NSLog(@"%f", height);
    UIView * headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, width, height);
    self.tableView.tableHeaderView = headerView;

    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = image;

    imageView.frame = CGRectMake(0, -64, width, height + 64);
    [headerView addSubview:imageView];

    //========= 使用分类方法 ============================ stone 🐳 ===========/

    [self.navigationController navigationControllerRequisiteSetupWithTotalOffset:height afterOffset:50.0 tableView:self.tableView barBackgroundColor:[UIColor yellowColor] fadeBar:YES];

    /** 移除navigationBar 底部 黑色分割线 */
    self.navigationController.showSplitLine = NO;
}

#pragma mark - <UITableViewDataSource>
/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //self.models.count;
}
/** 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 33;
}
/** cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:206 / 255.0 blue:166 / 255.0 alpha:1.0];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:154 / 255.0 blue:76 / 255.0 alpha:1.0];
    }
    return cell;
}

@end
