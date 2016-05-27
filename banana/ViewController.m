//
//  ViewController.m
//  banana
//
//  Created by 袁David on 16/4/5.
//  Copyright © 2016年 Yuan. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController (){
    NSInteger i;
}
//视频播放控制器
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) NSTimer *timer;
//
@property(nonatomic,strong) NSArray *labelStringArray;
//当前弹幕是否开启
@property (nonatomic,assign) BOOL isOpen;

@end

@implementation ViewController

-(NSArray *)labelStringArray
{
    if (!_labelStringArray) {
        NSString *pathstring = [[NSBundle mainBundle] pathForResource:@"Danmu.plist" ofType:nil];
        NSArray *array =  [NSArray arrayWithContentsOfFile:pathstring];
        _labelStringArray = array;
    }
    return _labelStringArray;
}

#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
    self.isOpen = NO;
    //定时去执行一个函数
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                                selector:@selector(addlable) userInfo:nil  repeats:YES];
    
    //设置定时器的时间
    [self.timer setFireDate:[NSDate distantFuture]];
    [self _initSwitch];
    
    
}
-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    //NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"心慌方BD中英双字.mp4" ofType:nil];
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"5-按钮连线完善.mov" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 -(NSURL *)getNetworkUrl{
 NSString *urlStr=@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
 urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 NSURL *url=[NSURL URLWithString:urlStr];
 return url;
 }
 */


/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}

-(void)addlable
{
    //获得整个屏幕的宽度和高度
    
    __block UILabel *label = [[UILabel alloc] init];
    NSInteger   labelHeight  = rand() % (NSInteger)[UIScreen mainScreen].bounds.size.height;
    label.frame = CGRectMake(self.view.frame.size.width,labelHeight , 300, 44);
    label.text = self.labelStringArray[i++];
    //    NSLog(@"%@---",self.labelStringArray[i++]);
    if (i == _labelStringArray.count) {
        i = 0;
    }
    
    [label setTextColor:[UIColor redColor]];
    [self.view addSubview:label];
    //NSLog(@"正在打印");
    
    //使label移动
    [self movelabel:label];
}
-(void)movelabel:(UILabel *)label
{
    //1，弹幕在8s内从右到左移动
    [UIView animateWithDuration:8 animations:^{
        label.frame = CGRectMake(0-label.frame.size.width,
                                 label.frame.origin.y,
                                 label.frame.size.width,
                                 label.frame.size.height);
    }completion:^(BOOL finished){
        //弹幕移动完以后要做的工作，例如，清理内存
        [label removeFromSuperview];
    }];
    
}
//手动添加按钮，开启弹幕喝关闭弹幕
-(void)_initSwitch
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 0, 200, 50);
    [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickedBtn:)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)clickedBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //改变title内容
    if(self.isOpen){
        [btn setTitle:@"开启弹幕" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
        /*前面的工作只能使弹幕不再产生，但已经产生的弹幕还是会在屏幕上移动，
         所以使弹幕立刻关闭，就要清空屏幕*/
        [self removeLabel];
        self.isOpen = NO;
    }else{
        //将启动定时器的时间设置为当前时间
        [self.timer setFireDate:[NSDate date]];
        [btn setTitle:@"关闭弹幕" forState:UIControlStateNormal];
        self.isOpen =YES;
    }
}

-(void)removeLabel
{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UILabel class]]){
            [view removeFromSuperview];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
