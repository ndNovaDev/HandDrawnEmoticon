//
//  MenuPopover.h
//  手绘表情
//
//  Created by 李庆阳 on 15/8/28.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol menuPopoerDelegate <NSObject>
-(void)finishWithButton:(UIButton *)btn;
@end


@interface MenuPopover : UIView
@property (nonatomic,weak)id<menuPopoerDelegate> delegate;

- (instancetype)initWithMenuFrame:(CGRect)frame;

- (void)show;


@end
