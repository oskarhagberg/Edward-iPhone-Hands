//
//  EDDrawingViewController.h
//  Edward iPhone Hands
//
//  Created by TaiwanYo on 9/11/12.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDBeerView.h"

@interface EDDrawingViewController : UIViewController <UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet EDBeerView *beerView;

@property (strong, nonatomic) NSString* drink;

@end
