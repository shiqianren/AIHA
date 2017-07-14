//
//  ShowLoveViewController.m
//  testPasterImage
//
//  Created by shiqianren on 2017/4/11.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import "ShowLoveViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ShowLoveViewController ()<UIWebViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;
@end

@implementation ShowLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initView];
		[self playMusic];
    // Do any additional setup after loading the view.
}
-(void)initView {
	self.title = @"大哈";
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
	self.webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
	self.webView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width,  UIScreen.mainScreen.bounds.size.height);
	[self.webView setScalesPageToFit:true];
	self.webView.scrollView.bounces = false;
	self.webView.delegate = self;
	[self.view addSubview:self.webView];
	NSString *path = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:path];
	NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index2"
														  ofType:@"html"];
	NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
													encoding:NSUTF8StringEncoding
													   error:nil];
	[self.webView loadHTMLString:htmlCont baseURL:baseURL];
	
	
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if (_musicPlayer != nil){
		//        [_musicPlayer playAtTime:<#(NSTimeInterval)#>];
		[_musicPlayer play];
	}
	[[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
	
}
-(UIWebView *)webView{
	if (!_webView){
		_webView = [[UIWebView alloc] init];
	}
	return _webView;
}
-(void)playMusic {
	_musicPlayer.delegate =self;
	// 获取音乐文件路径
	NSURL *musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"陈奕迅" ofType:@"mp3"]];
	
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
