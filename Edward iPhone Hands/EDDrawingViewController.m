//
//  EDDrawingViewController.m
//  Edward iPhone Hands
//
//  Created by TaiwanYo on 9/11/12.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDDrawingViewController.h"

@interface EDDrawingViewController ()
{
//    AccelerometerFilter *filter;
    int count;
    float fillLevel;
    NSDate* start;
    NSDate* end;
}

@end

@implementation EDDrawingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0 / 60.0];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    _beerView.level = 1;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBeerView:nil];
    [super viewDidUnload];
//    fillLevel = 0;
//    count = 0;
}


// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	// Update the accelerometer graph view
//	if(!isPaused)
//	{
//		[filter addAcceleration:acceleration];
//		[unfiltered addX:acceleration.x y:acceleration.y z:acceleration.z];
//		[filtered addX:filter.x y:filter.y z:filter.z];
//	}
    
    if (acceleration.x >= 0.5 && acceleration.x > 0) {
        // drinking
        start = [NSDate new];
    } else if (acceleration.x <= 1.0 && acceleration.x < 0) {
        // slam
        count++;
    } else if (acceleration.x <= 1.0 && acceleration.x > 0) {
        // stop drinking
        end = [NSDate new];
        NSTimeInterval interval = [end timeIntervalSinceNow];
        _beerView.level = _beerView.level - interval / 5.0;
        /// update alcohol level
        
    }
}


@end
