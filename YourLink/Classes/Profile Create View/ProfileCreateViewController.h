//
//  ProfileCreateViewController.h
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"
#import "Reachability.h"

@interface ProfileCreateViewController : UIViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate, UINavigationControllerDelegate>
{
    UIKeyboardViewController *keyBoardController;
    
    IBOutlet UIButton *tCsCheckBoxSelectButton;
    IBOutlet UIImageView *crossImage;
    IBOutlet UIImageView *passAlartImage;
    
    IBOutlet UITextField *contactNumberTextField;
    IBOutlet UITextField *emailTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *passwordAgainTextField;
    
    IBOutlet UIScrollView *confirmationAlartView;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}

@property (retain, nonatomic) IBOutlet UIButton *tCsCheckBoxSelectButton;
@property (retain, nonatomic) IBOutlet UIImageView *crossImage;
@property (retain, nonatomic) IBOutlet UIImageView *passAlartImage;

@property (retain, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) UITextField *passwordTextField;
@property (retain, nonatomic) UITextField *passwordAgainTextField;

@property(nonatomic,retain) UIView *tempView;
@property (nonatomic, strong) IBOutlet UIView *confirmationAlartView;

- (IBAction)createButton:(id)sender;
- (void) hideKeyboardWhenCreateButtonPressed;
- (IBAction)submitButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
