//
//  drawView.m
//  SuperDrawer
//
//  Created by 李庆阳 on 15/8/20.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "drawView.h"
#import "dModel.h"
@implementation drawView
#pragma mark - lazyArrayM
-(NSMutableArray *)arrayM{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}
#pragma mark - 触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    dModel *model = [[dModel alloc] init];
    model.color = self.color;
    model.width = self.width;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSValue valueWithCGPoint:point]];
    model.array = array;
    [self.arrayM addObject:model];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint cPoint = [touch locationInView:touch.view];
    dModel *dm = self.arrayM.lastObject;
    [dm.array addObject:[NSValue valueWithCGPoint:cPoint]];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint cPoint = [touch locationInView:touch.view];
    dModel *dm = self.arrayM.lastObject;
    [dm.array addObject:[NSValue valueWithCGPoint:cPoint]];
    [self setNeedsDisplay];
}
#pragma mark - 画画而已
-(void)drawRect:(CGRect)rect{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    for (dModel *dm in self.arrayM)
    {
        for (int i = 0; i < dm.array.count; i++)
        {
            if (i == 0)
            {
                CGPoint point = [dm.array[i] CGPointValue];
                CGContextMoveToPoint(ref, point.x, point.y);
            }else
            {
                CGPoint point = [dm.array[i] CGPointValue];
                CGContextAddLineToPoint(ref, point.x, point.y);
                CGContextSetLineWidth(ref, dm.width);
                [dm.color set];
            }
        }
        CGContextSetLineCap(ref, kCGLineCapRound);
        CGContextSetLineJoin(ref, kCGLineJoinRound);
        CGContextStrokePath(ref);
    }
    CGContextStrokePath(ref);
}
#pragma mark - 撤销、清除
-(void)back{
    [self.arrayM removeLastObject];
    [self setNeedsDisplay];
    
}
-(void)clear{
    [self.arrayM removeAllObjects];
    [self setNeedsDisplay];
}

@end
