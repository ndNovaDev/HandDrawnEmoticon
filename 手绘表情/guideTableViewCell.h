//
//  guideTableViewCell.h
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class guideModel;
@interface guideTableViewCell : UITableViewCell
//自定义的image
@property (nonatomic,strong)UIImageView *icon;
//数据模型（主要包含图片）
@property (nonatomic,strong)guideModel *guideModel;
-(instancetype)initWithTableView:(UITableView *)tableView;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
