//
//  EDLoginViewController.m
//  Edward iPhone Hands
//
//  Created by Oskar Hagberg on 2012-09-11.
//  Copyright (c) 2012 TaiwanYo. All rights reserved.
//

#import "EDLoginViewController.h"
#import "EDAppDelegate.h"

@interface EDLoginViewController ()

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)performLogin:(id)sender;

@end

@implementation EDLoginViewController

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    // FBSample logic
    // The user has initiated a login, so call the openSession method.
    EDAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSessionWithAllowLoginUI:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.spinner stopAnimating];
}

- (void)loginFailed {
    // FBSample logic
    // Our UI is quite simple, so all we need to do in the case of the user getting
    // back to this screen without having been successfully authorized is to
    // stop showing our activity indicator. The user can initiate another login
    // attempt by clicking the Login button again.
    [self.spinner stopAnimating];
}

- (void)viewDidUnload {
    self.spinner = nil;
    self.loginButton = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
