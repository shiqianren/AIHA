//
//  LeftViewController.m
//  testPasterImage
//
//  Created by shiqianren on 2017/4/10.
//  Copyright © 2017年 王迎博. All rights reserved.
//

#import "LeftViewController.h"
#import "ShowLoveViewController.h"
@interface LeftViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *woImage;
@property (weak, nonatomic) IBOutlet UIImageView *niImage;
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;

@end

@implementation LeftViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
	_woImage.userInteractionEnabled = YES;
	//添加长按手势
	UITapGestureRecognizer *recognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
	//长按响应时间
	//recognize.minimumPressDuration = 1;
	[_woImage addGestureRecognizer:recognize];
	
	//添加长按手势
	UITapGestureRecognizer *recognize1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
	//长按响应时间
	[_niImage addGestureRecognizer:recognize1];
	[self xuanzhuan];
    // Do any additional setup after loading the view.
	
	UITapGestureRecognizer *recon3= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLove)];
	_musicImage.userInteractionEnabled = YES;
	[_musicImage addGestureRecognizer:recon3];
	
}

-(void)tapLove{
	ShowLoveViewController *showLove = [[ShowLoveViewController alloc] init];
	[self.navigationController pushViewController:showLove animated:true];

}
- (void)longPress:(UITapGestureRecognizer *)sender {
	CABasicAnimation *animation = (CABasicAnimation *)[_woImage.layer animationForKey:@"rotation"];
	
	CABasicAnimation *animation1 = (CABasicAnimation *)[_niImage.layer animationForKey:@"rotation"];
	
	if (animation1 == nil) {
		[self shakeImage];
	}else {
		[self resume];
	}
	
	if (animation == nil) {
		[self shakeImage];
	}else {
		[self resume];
	}
}
- (void)shakeImage {
	//创建动画对象,绕Z轴旋转
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	
	//设置属性，周期时长
	[animation setDuration:0.08];
	
	//抖动角度
	animation.fromValue = @(-M_1_PI/2);
	animation.toValue = @(M_1_PI/2);
	//重复次数，无限大
	animation.repeatCount = HUGE_VAL;
	//恢复原样
	animation.autoreverses = YES;
	//锚点设置为图片中心，绕中心抖动
	_woImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
	
	[_woImage.layer addAnimation:animation forKey:@"rotation"];
	
	_niImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
	
	[_niImage.layer addAnimation:animation forKey:@"rotation"];
	
	
}


-(void)xuanzhuan{

	CABasicAnimation *animation = [ CABasicAnimation
								   animationWithKeyPath: @"transform" ];
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	
	//围绕Z轴旋转，垂直与屏幕
	animation.toValue = [ NSValue valueWithCATransform3D:
						 
						 CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
	animation.duration = 0.5;
	//旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
	animation.cumulative = YES;
	animation.repeatCount = HUGE_VAL;
	
	//在图片边缘添加一个像素的透明区域，去图片锯齿
	CGRect imageRrect = CGRectMake(0, 0,_musicImage.frame.size.width, _musicImage.frame.size.height);
	UIGraphicsBeginImageContext(imageRrect.size);
	[_musicImage.image drawInRect:CGRectMake(1,1,_musicImage.frame.size.width-2,_musicImage.frame.size.height-2)];
	_musicImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[_musicImage.layer addAnimation:animation forKey:nil];
	
	
	
}
//如果点击图标外区域，停止抖动
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];
	//转换坐标系，判断touch点是否在imageView内，在的话，仍然抖动，否则停止抖动
	CGPoint p = [self.view convertPoint:point toView:_woImage];
	if (![_woImage pointInside:p withEvent:event]) {
		NSLog(@"xxxxxxx");
		[self pause];
	}
	
	if (![_niImage pointInside:p withEvent:event]) {
		NSLog(@"xxxxxxx");
		[self pause];
	}
}

//layer.speed
/* The rate of the layer. Used to scale parent time to local time, e.g.
 * if rate is 2, local time progresses twice as fast as parent time.
 * Defaults to 1. */
//这个参数的理解比较复杂，我的理解是所在layer的时间与父layer的时间的相对速度，为1时两者速度一样，为2那么父layer过了一秒，而所在layer过了两秒（进行两秒动画）,为0则静止。
- (void)pause {
	_woImage.layer.speed = 0.0;
	
	_niImage.layer.speed = 0.0;
}

- (void)resume {
	_woImage.layer.speed = 1.0;
	_niImage.layer.speed = 1.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)call:(id)sender {
	
	NSString *phoneNum = @"15669981332";// 电话号码
	NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
	
	UIWebView *phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
	[phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
	[self.view addSubview:phoneCallWebView];
}


- (IBAction)weixin:(id)sender {
	  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
	
}

- (IBAction)Yanhuaclick:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设计师说烟花效果不好看，说以后交给他来实现" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"好哒", nil];
	[alert show];
	
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
