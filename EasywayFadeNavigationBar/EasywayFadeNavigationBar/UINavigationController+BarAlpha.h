//
//  UINavigationController+BarAlpha.h
//  kvo_test
//
//  Created by stone on 16/6/27.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (BarAlpha)
/** barAlpha : navigation alpha值*/
@property (nonatomic, assign) CGFloat barAlpha;
/** fadeBar */
@property (nonatomic, assign,readonly) BOOL fadeBar;

/** barBackgroundColor : navigationbar 背景色 */
@property (nonatomic,strong,readonly) UIColor * barBackgroundColor;

/** afterOffset : 希望过多少 contentOffset之后 开始变颜色,如果一开始的话 就 传 0 */
@property (nonatomic, assign,readonly) CGFloat afterOffset;

/** totalOffset : 从tableView顶部到第一个cell顶部距离, 即 tableHeaderView的高度... */
@property (nonatomic, assign,readonly) CGFloat totalOffset;

/** tableView */
@property (nonatomic,strong,readonly) UITableView * tableView;

/** Split line : 需要分割线吗? */
@property (nonatomic, assign) BOOL showSplitLine;

- (void)navigationControllerRequisiteSetupWithTotalOffset:(CGFloat)totalOffset afterOffset:(CGFloat)afterOffset tableView:(UITableView *)tableView barBackgroundColor:(UIColor*)barBackgroundColor fadeBar:(BOOL)fadeBar;

@end
