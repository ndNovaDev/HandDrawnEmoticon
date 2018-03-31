//
//  drawView.h
//  SuperDrawer
//
//  Created by 李庆阳 on 15/8/20.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawView : UIView
//画笔颜色
@property (nonatomic,strong)UIColor *color;
//画笔尺寸
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,strong)NSMutableArray *arrayM;
-(void)back;
-(void)clear;
@end
