//
//  DrawCircle.m
//  banana
//
//  Created by 袁David on 16/4/5.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "DrawCircle.h"

@implementation DrawCircle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    drawArc();
    
}

//绘制圆形
void drawCircle(){
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(50, 50,
                                                  100, 100));
    CGContextSetLineWidth(context, 10);
    //显示
    CGContextStrokePath(context);
}

//绘制圆弧
void drawArc(){
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context,100,100,50,M_PI_2,
                     M_PI,1);
    //CGContextStrokePath(context);
    CGContextFillPath(context);
}
@end
