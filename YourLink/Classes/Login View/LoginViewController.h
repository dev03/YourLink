//
//  LoginViewController.h
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Globals.h"
#import "UIKeyboardViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate, UINavigationControllerDelegate>
{
    UIKeyboardViewController *keyBoardController;
    
    IBOutlet UITextField *useridTextField;
    IBOutlet UITextField *passwordTextfield;
    IBOutlet UIButton *checkBoxSelectButton;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}

@property (retain, nonatomic) IBOutlet UITextField *useridTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (retain, nonatomic) IBOutlet UIButton *checkBoxSelectButton;

-(IBAction) loginButton:(id)sender;
-(IBAction) createAccountButton: (id)sender;
-(void) hideKeyboardWhenLoginButtonPressed;

@end