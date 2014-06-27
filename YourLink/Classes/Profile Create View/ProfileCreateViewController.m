//
//  ProfileCreateViewController.m
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import "ProfileCreateViewController.h"
#import "ValidationManager.h"
#import "UIView-AlertAnimations.h"
#import "ApplinkViewController.h"

@interface ProfileCreateViewController ()

@end

@implementation ProfileCreateViewController

@synthesize tCsCheckBoxSelectButton, crossImage, passAlartImage, emailTextField,tempView,confirmationAlartView,passwordTextField,passwordAgainTextField,contactNumberTextField;

int checkButtonClicked;
bool isCheckClicked;
NSString *contactNumber, *email, *password, *rePassword;
ValidationManager *inputValidator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*if([passwordFieldOne.text length]>0 && [passwordFieldTwo.text length]>0){
    if([passwordFieldOne.text isEqualToString:passwordFieldTwo.text]){
        NSLog(@"Hurray! Password matches ");
    }else{
        NSLog(@"Oops! Password does not matches");
    }
}else{
    NSLog(@"Password field can not be empty ");
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    checkButtonClicked=1;
    isCheckClicked=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CheckBox

-(IBAction)checkBoxAgreementButtonClicked
{
	if (checkButtonClicked == 1)
	{
        checkButtonClicked =0;
		isCheckClicked= 1;
		UIImage *buttonImage = [UIImage imageNamed:@"t&csCheckButton.png"];
		[tCsCheckBoxSelectButton setImage:buttonImage forState:UIControlStateNormal];
	}
	else
	{
		checkButtonClicked = 1;
		isCheckClicked=0;
		UIImage *buttonImage = [UIImage imageNamed:@"t&csUncheckButton.png"];
		[tCsCheckBoxSelectButton setImage:buttonImage forState:UIControlStateNormal];
	}
}

- (IBAction)createButton:(id)sender
{
    [self hideKeyboardWhenCreateButtonPressed];
    internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
	if ([[self updateInterfaceWithReachability: internetReach] isEqualToString:@"Not Reachable"])
	{
		[self processHasErrorsWithAddress];
	}
    else
    {
        NSString *replMessage = [self checkInput];
        if ([replMessage length] > 1)
        {
            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Creat Account Alert" message:replMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [_alert show];
        }
        else
        {
            tempView=[[UIView alloc] initWithFrame:CGRectMake(0,0,768,1028)];
            tempView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
            tempView.opaque = NO;
            tempView.userInteractionEnabled=YES;
            [self.view addSubview:tempView];
            
            [self.confirmationAlartView doPopInAnimationWithDelegate:self];
            [self.view doFadeInAnimation];
            confirmationAlartView.frame = CGRectMake (151, 389, 466, 262);
            
            [tempView addSubview:confirmationAlartView];
        }
    }
}

- (IBAction)submitButton:(id)sender
{
    ApplinkViewController *APVC = [[ApplinkViewController alloc] init];
    [self.navigationController pushViewController:APVC animated:YES];
    
    [self.tempView removeFromSuperview];
    [self.tempView doFadeInAnimationWithDelegate:self];
}

-(IBAction)cancelButton:(id)sender
{
    //[self resetTextField];
    [self.tempView removeFromSuperview];
    [self.tempView doFadeInAnimationWithDelegate:self];
}


#pragma mark - Text Field

-(NSString*)checkInput
{
	NSString *finalMessage = [NSString stringWithFormat:@""];
	
    contactNumber=contactNumberTextField.text;
	email=emailTextField.text;
    password=passwordTextField.text;
    rePassword=passwordAgainTextField.text;
    
	inputValidator = [[ValidationManager alloc]init];
	
    NSString *contactMsg = [NSString stringWithFormat:@""];
    if([contactNumber length] == 0)
    {
        contactMsg = @"Please fill out the Contact Number field.";
    }
    else if([inputValidator validateNumeric:contactNumber] == 1 )
	{
        contactMsg = @"";
	}
	else
	{
        contactMsg = @"Contact Number is invalid.";
    }
    
    NSString *emailMsg = [NSString stringWithFormat:@""];
	if([email length] == 0)
    {
        emailMsg = @"Please fill out the Email field.";
    }
    else if([inputValidator validateEmail:email] == 1 )
	{
        emailMsg = @"";
	}
	else
	{
        emailMsg = @"Email is invalid.";
    }
    
//	NSString *cellPhoneMsg = [inputValidator validationWithFixedParameter:cellPhoneTextField.text Length:10];
//	NSString *userNameMsg = [inputValidator validationWithRangeParameter:userName fromLength:5 toLength:100];
	NSString *passwordMsg = [inputValidator validationWithRangeParameter:password fromLength:2 toLength:20];
	
	if ([password isEqualToString:rePassword])
	{
		finalMessage = @"";
        crossImage.hidden = YES;
        passAlartImage.hidden=YES;
	}
	else
	{
		finalMessage = @"Your passwords do not match.";
        crossImage.hidden = NO;
        passAlartImage.hidden=NO;
        
	}
    
    if (([finalMessage length]>1) && ([contactMsg length]>1))
	{
		finalMessage = [NSString stringWithFormat:@"%@ %@",finalMessage,contactMsg];
	}
	else if ([contactMsg length]>1)
	{
        finalMessage = [NSString stringWithFormat:@"%@",contactMsg];
		if([inputValidator validateNumeric:contactNumber] ==1)
		{
			finalMessage = [NSString stringWithFormat:@"Contact Number is invalid.%@",finalMessage];
		}
	}
    
    if (([passwordMsg length]>1) && ([finalMessage length]>1))
    {
        finalMessage  = [NSString stringWithFormat:@"%@ YourLink password %@",finalMessage,passwordMsg];
    }
    else if([passwordMsg length]>1)
    {
        finalMessage = [NSString stringWithFormat:@" YourLink password %@",passwordMsg];
    }
    
    if (([finalMessage length]>1) && ([emailMsg length]>1))
	{
		finalMessage = [NSString stringWithFormat:@"%@ %@",finalMessage,emailMsg];
	}
	else if ([emailMsg length]>1)
	{
        finalMessage = [NSString stringWithFormat:@"%@",emailMsg];
		if([inputValidator validateEmail:email] ==1)
		{
			finalMessage = [NSString stringWithFormat:@"Email is invalid.%@",finalMessage];
		}
	}
    
    if (isCheckClicked == 0)
	{
		finalMessage = [NSString stringWithFormat:@"%@ Please confirm the t&Cs agreement",finalMessage];
	}
    
	return finalMessage;
}

//-(BOOL) textFieldShouldReturn:(UITextField *)theTextField
//{
//    if (theTextField == useridTextField)
//    {
//        [theTextField resignFirstResponder];
//        [passwordTextfield becomeFirstResponder];
//    }
//    else
//    {
//        [theTextField resignFirstResponder];
//    }
//    return YES;
//}

-(void) hideKeyboardWhenCreateButtonPressed
{
//    [useridTextField resignFirstResponder];
//    [passwordTextfield resignFirstResponder];
}

#pragma mark - Reachability

-(void)processHasErrorsWithAddress
{
	//Might be due to Internet
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Lost" message:@"Unable to connect with server. Please check your are connected to internet."
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

- (NSString*) configureTextField: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired= NO;
            statusString = @"Not Reachable";
            break;
        }
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            break;
        }
        case ReachableViaWiFi:
        {
			statusString= @"Reachable WiFi";
            break;
		}
    }
    if(connectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
    }
	return statusString;
}

- (NSString*) updateInterfaceWithReachability: (Reachability*) curReach
{
    if(curReach == hostReach)
	{
		//[self configureTextField: remoteHostStatusField imageView: remoteHostIcon reachability: curReach];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        BOOL connectionRequired= [curReach connectionRequired];
		//summaryLabel.hidden = (netStatus != ReachableViaWWAN);
        NSString* baseLabel=  @"";
        if(connectionRequired)
        {
            baseLabel=  @"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.";
        }
        else
        {
            baseLabel=  @"Cellular data network is active.\n  Internet traffic will be routed through it.";
        }
		NSLog(@"%@",baseLabel);
    }
	if(curReach == internetReach)
	{
		[self configureTextField: curReach];
	}
	if(curReach == wifiReach)
	{
		[self configureTextField: curReach];
	}
	NSString*str=[self configureTextField: curReach];
	return str;
}


@end
