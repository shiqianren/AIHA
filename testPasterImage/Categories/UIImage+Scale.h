//
//  UIImage+Scale.h
//  wuerwang
//
//  Created by shiqianren on 16/12/28.
//  Copyright © 2016年 shiqianren. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height;

- (double)ratioForImageToScaleWithMaxWidthOrHeight:(CGFloat)widthOrHeight;

/**
 *  将图片等比缩小
 *
 *  @param ratio 缩小几倍 如想缩小为原图的1/2 就传2.0
 *
 *  @return 缩小后的图
 */
- (UIImage *)transformWithRatio:(double)ratio;

- (UIImage *)transformWithMaxWidthOrHeight:(CGFloat)widthOrHeight;



/**
 缩放图片，以适应当前屏幕宽度

 @return 需要压缩到的尺寸
 */
- (UIImage *)zoomingToScreen;

@end
