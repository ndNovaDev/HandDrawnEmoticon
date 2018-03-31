//
//  guideTableViewCell.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "guideTableViewCell.h"
#import "guideModel.h"


@implementation guideTableViewCell
-(instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    self = [tableView dequeueReusableCellWithIdentifier:ID];
    if (self == nil) {
        self = [[guideTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        UIImageView *icon = [[UIImageView alloc] init];
        self.icon = icon;
        [self.contentView addSubview:icon];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    return [[self alloc] initWithTableView:tableView];
}
//重写set方法，顺便设置图片及尺寸
-(void)setGuideModel:(guideModel *)guideModel{
    _guideModel = guideModel;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * guideModel.image.size.height / guideModel.image.size.width + 20);
    self.icon.image = guideModel.image;
    self.icon.frame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * guideModel.image.size.height / guideModel.image.size.width);
}

@end
