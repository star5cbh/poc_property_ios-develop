/***********************************************************************************
 //  Zebra
 //
 //  Created by STAR on 15/5/7.
 //  Copyright (c) 2015年 peersafe. All rights reserved.
 // *
 ***********************************************************************************/


//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(ResizeCategory)
-(UIImage*)resizedImageToSize:(CGSize)dstSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
@end
