//
//  QuartHuman.m
//  banana
//
//  Created by 袁David on 16/4/5.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "QuartHuman.h"
#define JKRadius 70
#define JKTopY 100
#define JKColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation QuartHuman

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    drawBody(context, rect);
    drawMouse(context, rect);
    drawEyes(context, rect);
    drawcloth(context, rect);
    
}

//身体绘制
void drawBody(CGContextRef context,CGRect rect){
    CGFloat topX = rect.size.width * 0.5;
    CGFloat topY = JKTopY;
    CGFloat topRadius = JKRadius;
    CGContextAddArc(context, topX, topY, topRadius, 0, M_PI, 1);
    
    //线条的向下延伸
    CGFloat middleX= topX -topRadius;
    CGFloat middleH= JKTopY;
    CGFloat middleY= topY + middleH;
    CGContextAddLineToPoint(context, middleX, middleY);
    
    //下半圆
    CGFloat bottomX= topX;
    CGFloat bottomY= middleY;
    CGFloat bottomRadius= topRadius;
    CGContextAddArc(context, bottomX, bottomY, bottomRadius, M_PI, 0, 1);
    
    //合并路径
    CGContextClosePath(context);
    
    [JKColor(252, 218, 0)set];
    CGContextFillPath(context);

}

//嘴巴绘制
void drawMouse(CGContextRef context,CGRect rect){
    //设置一个控制点
    
    CGFloat controlX= rect.size.width *0.5;
    CGFloat controlY= rect.size.height *0.28;
    
    //设置当前点
    CGFloat marginX= 20;
    CGFloat marginY= 10;
    
    CGFloat currentX= controlX - marginX;
    CGFloat currentY= controlY - marginY;
    CGContextMoveToPoint(context, currentX, currentY);
    
    //设置结束点
    CGFloat endX= controlX + marginX;
    CGFloat endY= currentY;
    
    //绘制贝塞尔曲线
    CGContextAddQuadCurveToPoint(context, controlX, controlY, endX, endY);
    
    //颜色
    [[UIColor blackColor]set];
    
    CGContextStrokePath(context);
    
}
//衣服绘制
void drawcloth(CGContextRef context,CGRect rect){
    //背带裤
    CGFloat startX= rect.size.width *0.5;
    CGFloat startY= JKTopY + JKTopY * 0.7;
    CGContextMoveToPoint(context, startX, startY);
    
    CGFloat endX= rect.size.width  *0.5;
    CGFloat endY= JKTopY+ JKTopY;
    CGContextAddLineToPoint(context, endX, endY);
    CGContextSetLineWidth(context, JKRadius * 2);
    [JKColor(60, 100, 255)set];
    CGContextStrokePath(context);
    
    CGFloat clothX= rect.size.width *0.5;
    CGFloat clothY= JKTopY * 2;
    CGFloat clothRadius= JKRadius;
    CGContextAddArc(context, clothX, clothY, clothRadius, M_PI, 0, 1);
    [JKColor(60, 100, 255)set];
    CGContextFillPath(context);

    CGContextMoveToPoint(context, clothX - JKRadius, clothY);
    CGFloat lineEndX= clothX+ JKRadius;
    CGFloat lineEndY= clothY;
    CGContextAddLineToPoint(context, lineEndX, lineEndY);
    CGContextSetLineWidth(context,0.5);
    [[UIColor blackColor]set];
    CGContextStrokePath(context);
    
    //口袋绘制
    CGFloat controlX= clothX;
    CGFloat controlY= clothY +JKRadius * 0.5;
    //设置当前点
    CGFloat marginX= 25;
    CGFloat marginY= 20;
    CGFloat currentX= controlX - marginX;
    CGFloat currentY= controlY - marginY;
    CGContextMoveToPoint(context, currentX, currentY);
    //设置结束点
    CGFloat bagEndX= controlX + marginX;
    CGFloat bagEndY= currentY;
    
    //绘制贝塞尔曲线
    CGContextAddQuadCurveToPoint(context, controlX, controlY, bagEndX, bagEndY);
}
//眼睛绘制
void drawEyes(CGContextRef context,CGRect rect){
    //黑色绑带
    CGFloat startX= rect.size.width *0.5 -JKRadius;
    CGFloat startY= JKTopY;
    CGContextMoveToPoint(context, startX, startY);
    
    CGFloat endX= startX+ 2 * JKRadius;
    CGFloat endY= startY;
    CGContextAddLineToPoint(context, endX, endY);
    CGContextSetLineWidth(context, 15);
    
    [[UIColor blackColor]set];
    CGContextStrokePath(context);
    
    //灰色镜框
    [JKColor(61, 62, 66)set];
    CGFloat kuangLeftRadius = JKRadius * 0.4;
    CGFloat kuangLeftY= startY;
    CGFloat kuangLeftX= rect.size.width*0.5 - kuangLeftRadius;
    CGContextAddArc(context, kuangLeftX + 10, kuangLeftY, kuangLeftRadius, 0, M_PI*2, 0);

    CGFloat kuangRightRadius = JKRadius * 0.4;
    CGFloat kuangRightY= startY;
    CGFloat kuangRightX= rect.size.width*0.5 + kuangRightRadius;
    CGContextAddArc(context, kuangRightX + 10, kuangRightY, kuangRightRadius, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    //白色区域
    [[UIColor whiteColor]set];
    CGFloat whiteLeftRadius = kuangLeftRadius * 0.7;
    CGFloat whiteLeftX = kuangLeftX;
    CGFloat whiteLeftY = kuangLeftY;
    CGContextAddArc(context, whiteLeftX + 10, whiteLeftY, whiteLeftRadius, 0, M_PI*2, 0);

    CGFloat whiteRightRadius = kuangRightRadius * 0.7;
    CGFloat whiteRightX = kuangRightX;
    CGFloat whiteRightY = kuangRightY;
    CGContextAddArc(context, whiteRightX + 10, whiteRightY, whiteRightRadius, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    //眼睛
    [[UIColor blackColor]set];
    CGFloat blackLeftRadius = whiteLeftRadius * 0.5;
    CGFloat blackLeftX= whiteLeftX;
    CGFloat blackLeftY= whiteLeftY;
    CGContextAddArc(context, blackLeftX + 10, blackLeftY, blackLeftRadius, 0, M_PI*2, 0 );
    
    CGFloat blackRightRadius = whiteRightRadius * 0.5;
    CGFloat blackRightX= whiteRightX;
    CGFloat blackRightY= whiteRightY;
    CGContextAddArc(context, blackRightX + 10, blackLeftY, blackRightRadius, 0, M_PI*2, 0 );
    CGContextFillPath(context);
    
}
@end
