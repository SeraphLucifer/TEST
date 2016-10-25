//
//  XMGVcView.m
//  7.23CADisDisPlayLink定时器
//
//  Created by 谭伟 on 16/7/23.
//  Copyright © 2016年 谭伟. All rights reserved.
//

#import "XMGVcView.h"

@implementation XMGVcView

- (void)awakeFromNib
{
//    添加一个定时器,因为你这个view是是从sb中加载的,所以一加载完毕就会调用这个方法
//    [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
    //1.创建CADisplayLink定时器
        //这里面你指定的方法什么时候调用呢?
            //当下一次屏幕刷新(刷帧)的时候调用,(屏幕刷帧是一秒钟60次);
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(change)];
    //2.想要让CADisplayLink工作,必须得要把它添加到主运行循环当中.,后面随便写一个模式就可
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

static int _snowY = 0;

- (void)change
{
  
    _snowY += 10;
    if (_snowY >= [UIScreen mainScreen].bounds.size.height) {
        _snowY = 0;
    }
    
    //每来到这个方法就画一次,这个方法会清空画板
    [self setNeedsDisplay];
//    setNeedsDisplay方法会调用drawRect:方法,它并不是立马调用,是当下一次屏幕刷新(帧)时调用.那么这是方法和CADisplayLink的CADisplayLink方法是同步的,就会流畅,这样的话把NSTimer的时间改成1/60秒就也可以流畅了,但还是没setNeedsDisplay好
    
}

- (void)drawRect:(CGRect)rect {
    
    UIImage * image = [UIImage imageNamed:@"雪花"];

    [image drawAtPoint:CGPointMake(0, _snowY)];
    
}


@end
