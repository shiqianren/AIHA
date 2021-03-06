//
//  UIImage+Scale.m
//  wuerwang
//
//  Created by shiqianren on 16/12/28.
//  Copyright © 2016年 shiqianren. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)transformWidth:(CGFloat)width height:(CGFloat)height
{
    int intDestW = width + 0.5;
    int intDestH = height + 0.5;
    int intSourceW = width + 0.5;
    int intSourceH = height + 0.5;
    
    CGFloat destW = intDestW;
    CGFloat destH = intDestH;
    CGFloat sourceW = intSourceW;
    CGFloat sourceH = intSourceH;
    
    CGImageRef imageRef = self.CGImage;
    int bytesPerRow = destW * (CGImageGetBitsPerPixel(imageRef) >> 3);
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                bytesPerRow,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    CGContextDrawImage(bitmap, CGRectMake(0,0,sourceW,sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

- (double)ratioForImageToScaleWithMaxWidthOrHeight:(CGFloat)widthOrHeight
{
    double ratio = 1;
    
    CGFloat sourceW = self.size.width;
    CGFloat sourceH = self.size.height;
    
    if (sourceW <= widthOrHeight && sourceH <= widthOrHeight) {
        
    }
    else {
        double ratioX = sourceW / widthOrHeight;
        double ratioY = sourceH / widthOrHeight;
        
        ratio = ratioX > ratioY ? ratioX :ratioY;
    }
    
    return ratio;
}

- (UIImage *)transformWithRatio:(double)ratio
{
    UIImage *sourceImage = self;
    
    if (ratio > 1) {
        CGFloat destW = sourceImage.size.width / ratio;
        CGFloat destH = sourceImage.size.height / ratio;
        sourceImage = [self transformWidth:destW height:destH];
    }
    
    return sourceImage;
}

- (UIImage *)transformWithMaxWidthOrHeight:(CGFloat)widthOrHeight
{
    double ratio = [self ratioForImageToScaleWithMaxWidthOrHeight:widthOrHeight];
    return [self transformWithRatio:ratio];
}

- (UIImage *)zoomingToScreen
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = self.size.width;
    double ratio = 1.0;
    ratio = width / screenWidth;
    if (width >= screenWidth)
    {
        // 宽比屏幕大
        return [self transformWithRatio:ratio];
    }
    else
    {
        
        // 宽度没有屏幕大
        CGFloat destW = self.size.width * ratio;
        CGFloat destH = self.size.height * ratio;
        return [self transformWidth:destW height:destH];
    }
    
    
}

@end
