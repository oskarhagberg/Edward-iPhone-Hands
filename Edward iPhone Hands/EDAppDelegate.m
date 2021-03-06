//
//  EDAppDelegate.m
//  Edward iPhone Hands
//
//  Created by Oskar Hagberg on 2012-09-11.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDAppDelegate.h"
#import "EDViewController.h"
#import "EDLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

NSString *const EDSessionStateChangedNotification = @"com.taiwanyo.EdwardiPhoneHands:EDSessionStateChangedNotification";

@interface EDAppDelegate ()

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) EDViewController *mainViewController;
@property (strong, nonatomic) UIStoryboard* mainStoryBoard;

- (void)showLoginView;

@end


@implementation EDAppDelegate

#pragma mark -
#pragma mark Facebook Login Code

- (void)showLoginView {
    UIViewController *topViewController = [self.navController topViewController];
    UIViewController *modalViewController = [topViewController modalViewController];
    
    // FBSample logic
    // If the login screen is not already displayed, display it. If the login screen is displayed, then
    // getting back here means the login in progress did not successfully complete. In that case,
    // notify the login view so it can update its UI appropriately.
    if (![modalViewController isKindOfClass:[EDLoginViewController class]]) {
        EDLoginViewController* loginViewController = [self.mainStoryBoard instantiateViewControllerWithIdentifier:@"EDLoginViewController"];
        [topViewController presentModalViewController:loginViewController animated:NO];
    } else {
        EDLoginViewController* loginViewController = (EDLoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{
    // FBSample logic
    // Any time the session is closed, we want to display the login controller (the user
    // cannot use the application unless they are logged in to Facebook). When the session
    // is opened successfully, hide the login controller and show the main UI.
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController = [self.navController topViewController];
            if ([[topViewController modalViewController] isKindOfClass:[EDLoginViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }
            
            // FBSample logic
            // Pre-fetch and cache the friends for the friend picker as soon as possible to improve
            // responsiveness when the user tags their friends.
            FBCacheDescriptor *cacheDescriptor = [FBFriendPickerViewController cacheDescriptor];
            [cacheDescriptor prefetchAndCacheForSession:session];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // FBSample logic
            // Once the user has logged in, we want them to be looking at the root view.
            [self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EDSessionStateChangedNotification
                                                        object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", @"user_photos", nil];
    return [FBSession openActiveSessionWithPermissions:permissions
                                          allowLoginUI:allowLoginUI
                                     completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                         [self sessionStateChanged:session state:state error:error];
                                     }];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // FBSample logic
    // We need to handle URLs by passing them to FBSession in order for SSO authentication
    // to work.
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object; this is a good idea because
    // things may be hanging off the session, that need releasing (completion block, etc.) and
    // other components in the app may be awaiting close notification in order to do cleanup
    [FBSession.activeSession close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // this means the user switched back to this app without completing a login in Safari/Facebook App
    if (FBSession.activeSession.state == FBSessionStateCreatedOpening) {
        // BUG: for the iOS 6 preview we comment this line out to compensate for a race-condition in our
        // state transition handling for integrated Facebook Login; production code should close a
        // session in the opening state on transition back to the application; this line will again be
        // active in the next production rev
        //[FBSession.activeSession close]; // so we close our session and start over
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // BUG WORKAROUND:
    // Nib files require the type to have been loaded before they can do the
    // wireup successfully.
    // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
    [FBProfilePictureView class];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainViewController = [self.mainStoryBoard instantiateInitialViewController];
    self.navController = [[UINavigationController alloc]initWithRootViewController:self.mainViewController];
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    
    // FBSample logic
    // See if we have a valid token for the current state.
    if (![self openSessionWithAllowLoginUI:NO]) {
        // No? Display the login page.
        [self showLoginView];
    }
    
    return YES;
}

@end
