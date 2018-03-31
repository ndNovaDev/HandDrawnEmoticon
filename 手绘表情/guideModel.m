//
//  guideModel.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "guideModel.h"

@implementation guideModel
-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title;{
    if (self = [super init]) {
        self.image = image;
        self.title = title;
    }
    return self;
}
+(instancetype)guideModelWithImage:(UIImage *)image title:(NSString *)title;{
    return [[self alloc] initWithImage:image title:title];
}
@end
