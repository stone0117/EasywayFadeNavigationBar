# EasywayFadeNavigationBar
简单创建 淡入淡出的 navigationBar

![image](http://7xugrt.com1.z0.glb.clouddn.com/136.gif)
![image](http://7xugrt.com1.z0.glb.clouddn.com/136.gif)

```objc
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
```
