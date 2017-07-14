//
//  SnowViewController.m
//  testPasterImage
//
//  Created by shiqianren on 2017/4/11.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import "SnowViewController.h"
#import "HHSnowView.h"
#import <AVFoundation/AVFoundation.h>
@interface SnowViewController ()<AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;

@end

@implementation SnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	HHSnowView *snowView = [[HHSnowView alloc] initWithFrame:self.view.bounds withBackgroundImageName:@"snow_background.jpg" withSnowImgName:@"snow"];
	[snowView beginSnow];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-100, 150, 100)];
	imageView.alpha = 0.7;
	imageView.image = [UIImage imageNamed:@"xiaoren.jpeg"];
	
	[snowView addSubview:imageView];
	
	[self.view addSubview:snowView];
	[self playMusic];
	
    // Do any additional setup after loading the view.
}
-(void)playMusic {
	_musicPlayer.delegate =self;
	// 获取音乐文件路径
	NSURL *musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"陈小春-独家记忆" ofType:@"mp3"]];
	
	// 实例化音乐播放控件
	_musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
	
	// 准备（缓冲）播放
	[_musicPlayer prepareToPlay];
	
	// 开始播放音乐
	[_musicPlayer play];
	
}

-(void)viewWillAppear:(BOOL)animated{
	if (_musicPlayer != nil){
		//        [_musicPlayer playAtTime:<#(NSTimeInterval)#>];
		[_musicPlayer play];
	}
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	[_musicPlayer stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
