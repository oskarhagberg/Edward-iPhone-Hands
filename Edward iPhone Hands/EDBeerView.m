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

- (void)setLevel:(float)level
{
    _level = level;
    NSLog(@"Level %f", _level);
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor yellowColor] set];
    float y = 480 * (1 - _level);
    float height = 480 - y;
    CGRect rectangle = CGRectMake(0,y,320,height);
    CGContextFillRect(context, rectangle);
}

@end
