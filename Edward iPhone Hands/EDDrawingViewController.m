//
//  EDDrawingViewController.m
//  Edward iPhone Hands
//
//  Created by TaiwanYo on 9/11/12.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDDrawingViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "EDDrink.h"

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
        //facebook share
        [self postOpenGraphAction];
    } else if (acceleration.x <= 1.0 && acceleration.x > 0) {
        // stop drinking
        end = [NSDate new];
        NSTimeInterval interval = [end timeIntervalSinceNow];
        _beerView.level = _beerView.level - interval / 5.0;
        /// update alcohol level
        
    }
}


- (void)postOpenGraphAction
{
    // First create the Open Graph meal object for the meal we ate.
    id<EDDrink> result = (id<EDDrink>)[FBGraphObject graphObject];
    
    // Now create an Open Graph eat action with the meal, our location,
    // and the people we were with.
    id<EDDrinkAction> action = (id<EDDrinkAction>)[FBGraphObject graphObject];
//    action.meal = mealObject;
//    if (self.selectedPlace) {
//        action.place = self.selectedPlace;
//    }
//    if (self.selectedFriends.count > 0) {
//        action.tags = self.selectedFriends;
//    }
//    if (photoURL) {
//        NSMutableDictionary *image = [[NSMutableDictionary alloc] init];
//        [image setObject:photoURL forKey:@"url"];
//        
//        NSMutableArray *images = [[NSMutableArray alloc] init];
//        [images addObject:image];
//        
//        action.image = images;
//    }
//    
    // Create the request and post the action to the
    // "me/<YOUR_APP_NAMESPACE>:eat" path.
    [FBRequestConnection startForPostWithGraphPath:@"me/edwardhands:drink"
                                       graphObject:action
                                 completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         NSString *alertText;
         if (!error) {
             alertText = [NSString stringWithFormat:
                          @"Posted Open Graph action, id: %@",
                          [result objectForKey:@"id"]];
         } else {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         }
//         [[[UIAlertView alloc] initWithTitle:@"Result"
//                                     message:alertText
//                                    delegate:nil
//                           cancelButtonTitle:@"Thanks!"
//                           otherButtonTitles:nil]
//          show];
     }
     ];
}


@end
