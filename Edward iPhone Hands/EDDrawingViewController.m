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
#import "GraphView.h"

@interface EDDrawingViewController ()
{
//    AccelerometerFilter *filter;
    int count;
    float fillLevel;
    NSDate* start;
    NSDate* end;
    GraphView* graph;
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
    
    graph = [GraphView new];
    
    _beerView.level = 1;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBeerView:nil];
    [self setBeerView:nil];
    [super viewDidUnload];
//    fillLevel = 0;
//    count = 0;
}


// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (end != nil) {
        return;
    }
    
    [graph addX:acceleration.x y:acceleration.y z:acceleration.z];
    UIAccelerationValue acc = [graph currentX];

    if(acc < -1.0) {
        //Slam!
        end = [NSDate new];
        [self done];
        return;
    }
    
    if (start == nil) {
        start = [NSDate new];
    }
    
    acc = MAX(0,acc);
    if(_beerView.level > 0.1) {
        _beerView.level -= acc/1000.0;
    }
    
}

- (void)done
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Done!" message:@"Well done" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
