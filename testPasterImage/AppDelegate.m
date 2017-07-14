//
//  AppDelegate.m
//  testPasterImage
//
//  Created by 王迎博 on 16/9/5.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "AppDelegate.h"
#import "WZXLaunchViewController.h"
#import "HomeWebViewController.h"
#import "HomePageController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	self.window.rootViewController = storyboard.instantiateInitialViewController;
	//
	[self WZXLaunchView];
	[self.window makeKeyAndVisible];
    return YES;
}
- (void)WZXLaunchView{
	
	
	NSString *gifImageURL = @"http://img1.gamedog.cn/2013/06/03/43-130603140F30.gif";
	
	NSString *imageURL = @"http://img4.duitang.com/uploads/item/201410/24/20141024135636_t2854.thumb.700_0.jpeg";
	
	///设置启动页
	[WZXLaunchViewController showWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) ImageURL:gifImageURL advertisingURL:@"http://www.jianshu.com/p/7205047eadf7" timeSecond:5 hideSkip:NO imageLoadGood:^(UIImage *image, NSString *imageURL) {
		/// 广告加载结束
		NSLog(@"%@ %@",image,imageURL);
		
	} clickImage:^(UIViewController *WZXlaunchVC){
		
		/// 点击广告
		
		//2.在webview中打开
		HomeWebViewController *VC = [[HomeWebViewController alloc] init];
		VC.urlStr = @"http://www.jianshu.com/p/7205047eadf7";
		VC.title = @"广告";
		VC.AppDelegateSele= -1;
		
		VC.WebBack= ^(){
			//广告展示完成回调,设置window根控制器
			
			UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
			self.window.rootViewController = storyboard.instantiateInitialViewController;
		};
		
		
		//UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
	//	[WZXlaunchVC presentViewController:nav animated:YES completion:nil];
		
		
	} theAdEnds:^{
		
		
		//广告展示完成回调,设置window根控制器
		
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		self.window.rootViewController = storyboard.instantiateInitialViewController;
		
		
	}];
	
	
}
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
