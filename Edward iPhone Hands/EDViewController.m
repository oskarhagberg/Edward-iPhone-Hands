//
//  EDViewController.m
//  Edward iPhone Hands
//
//  Created by Oskar Hagberg on 2012-09-11.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDViewController.h"
#import "EDDrawingViewController.h"
#import "EDAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface EDViewController ()

@property (weak, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation EDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.userProfileImage.pictureCropping = FBProfilePictureCroppingSquare;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged:)
                                                 name:EDSessionStateChangedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserProfileImage:nil];
    [self setUserNameLabel:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    // A more complex app might check the state to see what the appropriate course of
    // action is, but our needs are simple, so just make sure our idea of the session is
    // up to date and repopulate the user's name and picture (which will fail if the session
    // has become invalid).
    [self populateUserDetails];
}

- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
             }
         }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EDDrawingViewController* vc = (EDDrawingViewController*)segue.destinationViewController;
    if ([@"startBeer" isEqualToString:segue.identifier]) {
        vc.drink = @"beer";
    } else if ([@"startWine" isEqualToString:segue.identifier]) {
        vc.drink = @"wine";
        
    } else if ([@"startMartini" isEqualToString:segue.identifier]) {
        vc.drink = @"martini";
        
        
    }
}

@end
