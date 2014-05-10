//
//  UIView+Frame.h
//  Lifesum
//
//  Created by Olle Lind on 27/02/14.
//  Copyright (c) 2014 Shape Up Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

-(void)setOriginX:(double)x;
-(void)setOriginY:(double)y;
-(void)setWidth:(double)width;
-(void)setHeight:(double)height;
-(void)positionBelowView:(UIView *)view;
-(void)positionBelowView:(UIView *)view withMargin:(double)margin;

@end
