//
//  howToButton.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "howToButton.h"


@implementation howToButton
//系统Btn不听话，重写
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
