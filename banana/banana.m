//
//  banana.m
//  banana
//
//  Created by 袁David on 16/4/5.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "banana.h"

@implementation banana

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//系统自动调用，视图显示在我们屏幕时调用并且只调用一次
-(void)drawRect:(CGRect)rect{
    drawTri();
    
}

void drawline(){
    //画线
    
    //1.获取图形上下文（获取窗体句柄
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将上下文复制一份到堆栈中
    CGContextSaveGState(context);
    //2.图形绘制
    //设置线段宽度
    CGContextSetLineWidth(context,3);
    //设置线段颜色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    //设置线条起点
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 100, 100);   
    //3.显示到View
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    //两条线
    [[UIColor blueColor] set];
    //设置线条头部和尾部的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线条转折点的样式
    CGContextSetLineJoin(context,kCGLineCapRound);
    CGContextMoveToPoint(context, 100, 120);
    CGContextAddLineToPoint(context, 150, 120);
    CGContextAddLineToPoint(context, 150, 180);
    CGContextStrokePath(context);
}

//绘制填充四边形
void drawR(){
    //1.图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.绘制
    CGContextAddRect(context, CGRectMake(10, 10, 120, 120));
    [[UIColor purpleColor] setFill];
    //3.显示
    CGContextFillPath(context);
}

//绘制三角形
void drawTri(){
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 150, 100);
    CGContextClosePath(context);
    [[UIColor redColor] set];
    CGContextStrokePath(context);
}

//绘制圆形
@end
