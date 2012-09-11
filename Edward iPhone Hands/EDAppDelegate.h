//
//  EDAppDelegate.h
//  Edward iPhone Hands
//
//  Created by Oskar Hagberg on 2012-09-11.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EDSessionStateChangedNotification;

@interface EDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// FBSample logic
// The app delegate is responsible for maintaining the current FBSession. The application requires
// the user to be logged in to Facebook in order to do anything interesting -- if there is no valid
// FBSession, a login screen is displayed.
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
