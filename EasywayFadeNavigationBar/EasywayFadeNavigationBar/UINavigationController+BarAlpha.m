//
//  UINavigationController+BarAlpha.m
//  kvo_test
//
//  Created by stone on 16/6/27.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "UINavigationController+BarAlpha.h"
#import <objc/runtime.h>

@implementation NSObject (BarAlpha)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2 {
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@interface UINavigationController ()

/** bgView */
@property(strong, nonatomic) UIView * bgView;

@end

@implementation UINavigationController (BarAlpha)

+ (void)load {
    [self exchangeInstanceMethod1:NSSelectorFromString(@"dealloc") method2:NSSelectorFromString(@"sn_dealloc")];
}
- (void)sn_dealloc {
    [self sn_dealloc];

    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

//=========  ============================ stone 🐳 ===========/

/*
 self.navigationController.totalOffset = HEIGHT;
 self.navigationController.afterOffset = TEMP;
 self.navigationController.tableView = self.tableView;
 self.navigationController.barBackgroundColor = [UIColor yellowColor];
 self.navigationController.fadeBar = YES;
 */

- (void)navigationControllerRequisiteSetupWithTotalOffset:(CGFloat)totalOffset afterOffset:(CGFloat)afterOffset tableView:(UITableView *)tableView barBackgroundColor:(UIColor *)barBackgroundColor fadeBar:(BOOL)fadeBar {

    self.totalOffset = totalOffset;
    self.afterOffset = afterOffset;
    self.tableView = tableView;
    self.barBackgroundColor = barBackgroundColor;
    self.fadeBar = fadeBar;
}
//=========  ============================ stone 🐳 ===========/

- (BOOL)showSplitLine {

    NSNumber * number = objc_getAssociatedObject(self, _cmd);

    return number.boolValue;
}

- (void)setShowSplitLine:(BOOL)showSplitLine {

    objc_setAssociatedObject(self, @selector(showSplitLine), @(showSplitLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (showSplitLine) {
        //
    } else {

        self.navigationBar.shadowImage = [self imageWithColor:[UIColor clearColor]];
    }
}
//=========  ============================ stone 🐳 ===========/
- (UITableView *)tableView {

    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTableView:(UITableView *)tableView {

    objc_setAssociatedObject(self, @selector(tableView), tableView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
//=========  ============================ stone 🐳 ===========/
- (BOOL)fadeBar {

    NSNumber * number = objc_getAssociatedObject(self, _cmd);

    return number.boolValue;
}

- (void)setFadeBar:(BOOL)fadeBar {

    objc_setAssociatedObject(self, @selector(fadeBar), @(fadeBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}
/**
 * 监听属性值发生改变时回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    //=========  ============================ stone 🐳 ===========/
    /** 核心公式 */
    CGFloat offset = self.tableView.contentOffset.y;
    //    CGFloat delta = offset / 200.f + 64/200.f;

    /** 多少高度之后开始变淡 */
    CGFloat temp = self.afterOffset;

    /** tableHeaderView 高度 */
    CGFloat headerViewHeight = self.totalOffset;

    CGFloat delta = (offset - temp) / (headerViewHeight - temp - 64.0); //36.f;

    //    CGFloat delta = offset / 64.f + 1.f;

    //    NSLog(@"%f offset=%f", delta, offset);

    delta = MAX(0, delta);

    self.barAlpha = MIN(1, delta);

    //=========  ============================ stone 🐳 ===========/
}

//=========  ============================ stone 🐳 ===========/
- (CGFloat)totalOffset {

    NSNumber * number = objc_getAssociatedObject(self, _cmd);

    return number.floatValue;
}

- (void)setTotalOffset:(CGFloat)totalOffset {

    objc_setAssociatedObject(self, @selector(totalOffset), @(totalOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//=========  ============================ stone 🐳 ===========/
- (CGFloat)afterOffset {

    NSNumber * number = objc_getAssociatedObject(self, _cmd);

    return number.floatValue;
}

- (void)setAfterOffset:(CGFloat)afterOffset {

    objc_setAssociatedObject(self, @selector(afterOffset), @(afterOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//=========  ============================ stone 🐳 ===========/
/** bgView 懒加载 */
- (UIView *)bgView {

    UIView * bgView = objc_getAssociatedObject(self, _cmd);
    if (bgView == nil) {

        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.bgView = bgView;
    }
    return bgView;
}
- (void)setBgView:(UIView *)bgView {

    objc_setAssociatedObject(self, @selector(bgView), bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//===================================== stone ===========/
- (UIColor *)barBackgroundColor {

    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {

    objc_setAssociatedObject(self, @selector(barBackgroundColor), barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    self.bgView.backgroundColor = barBackgroundColor;

    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];

    [self.navigationBar insertSubview:self.bgView atIndex:0];
}
//=========  ============================ stone 🐳 ===========/
- (CGFloat)barAlpha {

    NSNumber * number = objc_getAssociatedObject(self, _cmd);

    return number.floatValue;
}

- (void)setBarAlpha:(CGFloat)barAlpha {

    objc_setAssociatedObject(self, @selector(barAlpha), @(barAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    self.bgView.alpha = barAlpha;
}

//========= tool 以下代码 不用看 拿过去用就行============================ stone 🐳 ===========/
/** 16进制(字符串形式) 返回 图片 */
- (UIImage *)imageWithString:(NSString *)string {

    return [self imageWithColor:[self colorWithString:string]];
}
/** 16进制返回颜色 */
- (UIColor *)colorWithString:(NSString *)string {
    CGFloat alpha = 1.0f;
    NSNumber * red = @0.0;
    NSNumber * green = @0.0;
    NSNumber * blue = @0.0;

    NSMutableArray<NSNumber *> * colors = [NSMutableArray arrayWithArray:@[ red, green, blue ]];

    unsigned hexComponent;
    NSString * colorString = [string uppercaseString];
    //    NSLog(@"%ld", colors.count);
    for (int i = 0; i < colors.count; i++) {
        NSString * substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];

        [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];

        NSNumber * temp = colors[i];
        temp = @(hexComponent / 255.0);
        colors[i] = temp;
    }

    return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
}
/** 颜色 返回 图片 */
- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
