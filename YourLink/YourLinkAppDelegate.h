//
//  SplashAppDelegate.h
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@class SplashViewController;

@interface YourLinkAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navCont;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain) UINavigationController *navCont;
@property (strong, nonatomic) SplashViewController *viewController;

@end
