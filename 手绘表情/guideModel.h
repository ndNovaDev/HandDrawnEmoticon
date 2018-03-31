//
//  guideModel.h
//  手绘表情
//
//  Created by 李庆阳 on 15/8/29.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface guideModel : NSObject
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,copy)NSString *title;
-(instancetype)initWithImage:(UIImage *)image title:(NSString *)title;
+(instancetype)guideModelWithImage:(UIImage *)image title:(NSString *)title;
@end
