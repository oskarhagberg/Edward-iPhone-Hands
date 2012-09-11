//
//  EDBeerView.m
//  Edward iPhone Hands
//
//  Created by TaiwanYo on 9/11/12.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDBeerView.h"

@interface EDBeerView ()

@end

@implementation EDBeerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:192 green:110 blue:56 alpha:1].CGColor);
    float y = 480 * (1 - _level);
    float height = 480 - y;
    CGRect rectangle = CGRectMake(0,y,320,height);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:192 green:110 blue:56 alpha:1].CGColor);
    CGContextFillRect(context, rectangle);
}

@end
