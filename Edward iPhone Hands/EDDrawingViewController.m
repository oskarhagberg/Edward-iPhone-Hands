//
//  EDDrawingViewController.m
//  Edward iPhone Hands
//
//  Created by TaiwanYo on 9/11/12.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDDrawingViewController.h"

@interface EDDrawingViewController ()

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBeerImageView:nil];
    [super viewDidUnload];
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
}


@end
