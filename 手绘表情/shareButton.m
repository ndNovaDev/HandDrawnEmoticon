//
//  shareButton.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "shareButton.h"

@implementation shareButton
//系统自带按钮不听话，重写
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
}
@end
