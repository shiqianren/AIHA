//
//  ViewController.m
//  testPasterImage
//
//  Created by 王迎博 on 16/9/5.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "YBPasterImageVC.h"
//#import "UIViewController+Swizzling.h"
#import "HHSnowView.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "UIImage+Scale.h"
@interface ViewController ()<AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
// 声明音乐播放控件，必须声明为全局属性变量，否则可能不会播放，AVAudioPlayer 只能播放本地音乐
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UIImageView *choseImage;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *selectImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----------------%f",_imageView.frame.origin.x);
     _imageView.hidden = true;
    HHSnowView *snowView = [[HHSnowView alloc] initWithFrame:self.view.bounds withBackgroundImageName:@"sky.jpg" withSnowImgName:@"snow"];
    _choseImage = [[UIImageView alloc] init];
	
    _choseImage.frame = CGRectMake(10, 0, self.view.frame.size.width-20,self.view.frame.size.width);
    _choseImage.image = [UIImage imageNamed:@"mei1"];
	 _choseImage.image = [_choseImage.image zoomingToScreen];
	
	_choseImage.frame = CGRectMake(0, 0,  _choseImage.image.size.width,_choseImage.image.size.height);
    [snowView addSubview:_choseImage];
    [snowView beginSnow];
    [self.view addSubview:snowView];
    [self.view sendSubviewToBack:snowView];
    [[UIApplication sharedApplication] setStatusBarHidden:YES] ;
    [self playMusic];
}

-(void)playMusic {
    _musicPlayer.delegate =self;
    // 获取音乐文件路径
    NSURL *musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"aa" ofType:@"mp3"]];
    
    // 实例化音乐播放控件
    _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    
    // 准备（缓冲）播放
    [_musicPlayer prepareToPlay];
    
    // 开始播放音乐
    [_musicPlayer play];
    
}
- (IBAction)imgaeClick:(UIButton *)sender {
}
- (IBAction)BackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
    
}
- (IBAction)chagePhoto:(UIButton *)sender {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentViewController:self.imagePicker animated:YES completion:nil];
	}];
	
	UIAlertAction *photoLibiaryAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		[self presentViewController:self.imagePicker animated:YES completion:nil];
	}];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	
	[alertController addAction:takePhotoAction];
	[alertController addAction:photoLibiaryAction];
	[alertController addAction:cancelAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

-(void)touchMe{

    NSLog(@"点击了图片啊");
}
-(void)viewWillAppear:(BOOL)animated{
    if (_musicPlayer != nil){
        //        [_musicPlayer playAtTime:<#(NSTimeInterval)#>];
        [_musicPlayer play];
    }
 [self.navigationController setNavigationBarHidden:YES] ;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_musicPlayer stop];
}
/**
 *  跳转到下页
 */
- (IBAction)addPasterImage:(UIButton *)sender
{
    YBPasterImageVC *pasterVC = [[YBPasterImageVC alloc]init];
	if (_selectImage != nil){
		pasterVC.originalImage = _selectImage;
	}else {
	    pasterVC.originalImage = [UIImage imageNamed:@"mei1"];
	}
	
    
    pasterVC.block = ^(UIImage *editedImage){
       _choseImage.image = editedImage;
    };
    
    [self.navigationController pushViewController:pasterVC animated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
	
	UIImage *image = info[UIImagePickerControllerEditedImage];
	_choseImage.image = image;
	_choseImage.image = [_choseImage.image zoomingToScreen];
	_choseImage.frame = CGRectMake(0, 0,  _choseImage.image.size.width,_choseImage.image.size.height);
	_selectImage = image;
	[picker dismissViewControllerAnimated:YES completion:^{
		// 直接上传图片
	
	}];
}

- (IBAction)saveImgae:(id)sender {
	[[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
		
		//写入图片到相册
	
		
		PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:_choseImage.image];
		
		
	} completionHandler:^(BOOL success, NSError * _Nullable error) {
		if (success == true){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"气人" message:@"你又保存了一张美美的照片" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
			[alert show];
		}
		NSLog(@"success = %d, error = %@", success, error);
		
	}];
	
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}
- (UIImagePickerController *)imagePicker
{
	if (!_imagePicker)
	{
		_imagePicker = [[UIImagePickerController alloc] init];
		_imagePicker.delegate = self;
		_imagePicker.allowsEditing = YES;
	}
	return _imagePicker;
}
@end
