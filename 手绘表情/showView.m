//
//  showView.m
//  SuperDrawer
//
//  Created by 李庆阳 on 15/8/20.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "showView.h"

@implementation showView
-(void)drawRect:(CGRect)rect{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, self.frame.size.width * 0.5,self.frame.size.width * 0.5);
    CGContextAddLineToPoint(ref,self.frame.size.width * 0.5,self.frame.size.width * 0.5);
    CGContextSetLineCap(ref, kCGLineCapRound);
    [self.color set];
    CGContextSetLineWidth(ref, self.width);
    CGContextStrokePath(ref);
}
-(void)setWidth:(CGFloat)width{
    _width = width;
    [self setNeedsDisplay];
}
-(void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}
@end
