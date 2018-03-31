//
//  dModel.h
//  SuperDrawer
//
//  Created by 李庆阳 on 15/8/20.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface dModel : NSObject
//保存路径点的数组
@property (nonatomic,strong)NSMutableArray *array;
//画笔颜色
@property (nonatomic,strong)UIColor *color;
//画笔尺寸
@property (nonatomic,assign)CGFloat width;
@end
