//
//  HomeViewController.m
//  testPasterImage
//
//  Created by shiqianren on 2017/4/8.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import "HomePageController.h"
#import "DMHeartFlyView.h"
#import "PSY3D_CircleAnimationView.h"
#import "DNOLabelAnimation.h"
#import "LeftViewController.h"
#import <AVFoundation/AVFoundation.h>
#define myRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define myWidth  [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

@interface HomePageController ()<AVAudioPlayerDelegate>{

    CGFloat _heartSize;
    NSTimer *_burstTimer;
     NSTimer *theTimer;
    NSTimer *labelTimer;
}
// 声明音乐播放控件，必须声明为全局属性变量，否则可能不会播放，AVAudioPlayer 只能播放本地音乐
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;
@property(nonatomic,strong)UIImageView *imageView;
@property (strong, nonatomic)PSY3D_CircleAnimationView *circleView;
@property (nonatomic, strong) NSMutableArray *textViews;
@property (nonatomic, assign) DNOLabelAnimationType type;
@end

@implementation HomePageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO] ;
    if (_musicPlayer != nil){
//        [_musicPlayer playAtTime:<#(NSTimeInterval)#>];
        [_musicPlayer play];
    }
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    
}

- (IBAction)leftClick:(id)sender {
//    LeftViewController *leftView = [[LeftViewController alloc] init];
//    [self.navigationController presentViewController:leftView animated:true completion:nil];
//    [self.navigationController pushViewController:leftView animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _heartSize = 40;
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTheLove)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGesture];
    [self rightImage];
    [self initializetion];
    [self demo5];
    [self playMusic];
    
    // Do any additional setup after loading the view.
}

-(void)rightImage{
    NSArray *imageArr = @[@"mei1",
                          @"mei3",
                          @"mei4",
                          @"mei5",
                          @"mei6",
                          @"IMG_2418.jpg",
                          @"mei7.jpg",
                          @"mei8.jpg",
						  @"mei13.jpg",
                          @"mei9.jpg",
						   @"mei10.jpg",
						   @"mei11.jpg"
                        ];
    
    self.circleView = [[PSY3D_CircleAnimationView alloc] initWithFrame:CGRectMake(10, 64, myWidth-20, myHeight-150)];
    self.circleView.alpha = 0.7;
    self.circleView.animationDurtion = 3.0f;
    self.circleView.duration = 1.2f;
    self.circleView.animationType = PSY3DAnimationTpyeCube;
    self.circleView.toLeftSubtype = PSY3DDirectionSubtypeFromRight;
    self.circleView.toRightSubtype = PSY3DDirectionSubtypeFromLeft;
    self.circleView.PSY3D_ImageDataSource = imageArr;
    [self.view addSubview:self.circleView];
    // 回调方法处理
    self.circleView.userClickBlock = ^(NSInteger index)
    {
        NSLog(@"点击了第%ld张图片",index);
    };
}

- (void)demo5 {
    
    DNOLabelAnimation *textView = [[DNOLabelAnimation alloc] initWithFrame:CGRectMake(0,myHeight-49, myWidth, 49) text:@"做人呢,最重要的就是不能让别人开心.但一定要得让你开心"];
    
    textView.type = self.type;
    textView.numberOfLines = 2;
    textView.font = [UIFont systemFontOfSize:8];
    textView.kerning = 4;
//    [textView sizeToFit];
    [self.view addSubview:textView];
    [self.textViews addObject:textView];
    [self.textViews[0] startAnimation];
    
}




//实现方法
- (void)initializetion{
    if (theTimer == nil){
        float theInterval = 1.0f/20.0f;//1秒执行30次
        theTimer = [NSTimer scheduledTimerWithTimeInterval:theInterval
                                                    target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
    }
    if(labelTimer == nil){
         float theInterval = 5;//1秒执行30次
        labelTimer = [NSTimer scheduledTimerWithTimeInterval:theInterval
                                                    target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
    }
    
}  



-(void)playMusic {
    _musicPlayer.delegate =self;
    // 获取音乐文件路径
    NSURL *musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"李玉刚-刚好遇见你" ofType:@"mp3"]];
    
    // 实例化音乐播放控件
    _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    
    // 准备（缓冲）播放
    [_musicPlayer prepareToPlay];
    
    // 开始播放音乐
    [_musicPlayer play];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_musicPlayer stop];
}

// 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"唱完了啊");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showTheLove{
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(30 + _heartSize/2.0, self.view.bounds.size.height - _heartSize/2.0 - 20);
    heart.center = fountainSource;
    [heart animateInView:self.view];
}

-(void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            _burstTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
            break;
        case UIGestureRecognizerStateEnded:
            [_burstTimer invalidate];
            _burstTimer = nil;
            break;
        default:
            break;
    }
}
- (NSMutableArray *)textViews
{
    if (!_textViews) {
        _textViews = [[NSMutableArray alloc] init];
    }
    return _textViews;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
