//
//  guideTableViewController.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "guideTableViewController.h"
#import "guideModel.h"
#import "guideTableViewCell.h"
@interface guideTableViewController ()
//存放组与组头信息的数组
@property (nonatomic,strong)NSArray *picS;
@end
@implementation guideTableViewController
#pragma mark - lazy
-(NSArray *)picS{
    if (!_picS) {
        guideModel *md0 = [guideModel guideModelWithImage:[UIImage imageNamed:@"beginSet"] title:@"1.点击 “系统相册” 按钮,将绘制好的表情保存至系统相册"];
        guideModel *md1 = [guideModel guideModelWithImage:[UIImage imageNamed:@"step1"] title:@"2.进入《微信》，选择“我”标签，点击“表情”按钮"];
        guideModel *md2 = [guideModel guideModelWithImage:[UIImage imageNamed:@"step2"] title:@"3.点击右上角齿轮形状的设置按钮"];
        guideModel *md3 = [guideModel guideModelWithImage:[UIImage imageNamed:@"step3"] title:@"4.点击“我收藏的表情"];
        guideModel *md4 = [guideModel guideModelWithImage:[UIImage imageNamed:@"step4"] title:@"5.点击如图所示的“+”"];
        guideModel *md5 = [guideModel guideModelWithImage:[UIImage imageNamed:@"step5"] title:@"6.《微信》将会自动跳转到系统相册，选择刚刚绘制好并保存进相册的表情，点击“确定”，现在就可以跟小伙伴们炫耀了！"];
        _picS = @[md0,md1,md2,md3,md4,md5];
    }
    return _picS;
}
#pragma mark - UI
//重写init，使本页面初始化为grouped
-(instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
//Viewdidload（其中有本界面的关闭按钮）
- (void)viewDidLoad {
    [super viewDidLoad];
    //    关闭按钮
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.tableView.allowsSelection = NO;
}
//关闭按钮点击事件
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - DataSourse\Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.picS.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    guideModel *gm = self.picS[indexPath.section];
    guideTableViewCell *cell = [guideTableViewCell cellWithTableView:tableView];
    cell.guideModel = gm;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    guideModel *gm = self.picS[section];
    return gm.title;
}
@end
