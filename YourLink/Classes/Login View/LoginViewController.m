//
//  LoginViewController.m
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import "LoginViewController.h"
#import "ValidationManager.h"
#import "ProfileCreateViewController.h"
#import "MyHomeViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize useridTextField, passwordTextfield, checkBoxSelectButton;

int checkButtonClicked;
bool isCheckClicked;
NSString *user, *password;
ValidationManager *inputValidator;
//UIImageView *activityImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    passwordTextfield.secureTextEntry = YES;
    
    checkButtonClicked=1;
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *user = [def stringForKey:@"userID"];
    NSString *pass = [def stringForKey:@"password"];
    useridTextField.text = user;
    passwordTextfield.text = pass;
    
    if (user!=nil)
    {
        checkButtonClicked =0;
		isCheckClicked=1;
		UIImage *buttonImage = [UIImage imageNamed:@"Form_Check_On.png"];
		[checkBoxSelectButton setImage:buttonImage forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
		UIImage *buttonImage = [UIImage imageNamed:@"Form_Check_On.png"];
		[checkBoxSelectButton setImage:buttonImage forState:UIControlStateNormal];
	}
	else
	{
		checkButtonClicked = 1;
		isCheckClicked=0;
		UIImage *buttonImage = [UIImage imageNamed:@"Form_Check_Off.png"];
		[checkBoxSelectButton setImage:buttonImage forState:UIControlStateNormal];
	}
}

#pragma mark - Login

- (IBAction)loginButton:(id)sender
{
    [self hideKeyboardWhenLoginButtonPressed];
    internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
	if ([[self updateInterfaceWithReachability: internetReach] isEqualToString:@"Not Reachable"])
	{
		[self processHasErrorsWithAddress];
	}
    else
    {
        NSString *replMessage = [self getInput];
        if ([replMessage length] > 1)
        {
            UIAlertView *_alert = [[UIAlertView alloc] initWithTitle:@"Login Alert" message:replMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [_alert show];
        }
        else
        {
            if (isCheckClicked==1)
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                NSString *useridText = useridTextField.text;
                [defaults setObject:useridText forKey:@"userID"];
                NSString *passwordText = passwordTextfield.text;
                [defaults setObject:passwordText forKey:@"password"];
                [defaults synchronize];
            }
            else if (isCheckClicked==0)
            {
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            }
            MyHomeViewController *MHVC = [[MyHomeViewController alloc] init];
            [self.navigationController pushViewController:MHVC animated:YES];
        }
    }
}

-(IBAction) createAccountButton: (id)sender
{
    ProfileCreateViewController *PCVC = [[ProfileCreateViewController alloc] init];
    [self.navigationController pushViewController:PCVC animated:YES];
}

/*- (IBAction)ForgotIDButton:(id)sender
 {
 }
 
 - (IBAction)forgotPassButton:(id)sender
 {
 }*/

#pragma mark - Text Field

-(NSString*)getInput
{
	NSString *finalMessage = [NSString stringWithFormat:@""];
	
	user=useridTextField.text;
	password=passwordTextfield.text;
	
	inputValidator = [[ValidationManager alloc]init];
    
	NSString *message = [inputValidator validationWithFixedParameter:user Length:2];
	NSString *message1= [inputValidator validationWithRangeParameter:password fromLength:2 toLength:20];
    
    if (([message length]>1) && ([message1 length]>1))
    {
        //finalMessage = [NSString stringWithFormat:@"phone %@ and Password %@", message,message1];
        finalMessage = [NSString stringWithFormat:@"Please enter valid ID or password."];
    }
    else if ([message length]>1)
    {
        //finalMessage = [NSString stringWithFormat:@"phone %@",message];
        finalMessage = [NSString stringWithFormat:@"Please enter valid ID or password."];
    }
    else if([message1 length]>1)
    {
        //finalMessage = [NSString stringWithFormat:@"password %@",message1];
        finalMessage = [NSString stringWithFormat:@"Please enter valid ID or password."];
    }
	return finalMessage;
}

-(BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == useridTextField)
    {
        [theTextField resignFirstResponder];
        [passwordTextfield becomeFirstResponder];
    }
    else
    {
        [theTextField resignFirstResponder];
    }
    return YES;
}

-(void) hideKeyboardWhenLoginButtonPressed
{
    [useridTextField resignFirstResponder];
    [passwordTextfield resignFirstResponder];
}

/*#pragma mark - Activity Indicator

-(void)startAnimation:(id)data
{
	UIImage *statusImage = [UIImage imageNamed:@"Load_01"];
	activityImageView = [[UIImageView alloc] initWithImage:statusImage];
	activityImageView.backgroundColor=[UIColor clearColor];
    
	activityImageView.animationImages = [NSArray arrayWithObjects:
										 [UIImage imageNamed:@"Load_01"],
										 [UIImage imageNamed:@"Load_02"],
										 [UIImage imageNamed:@"Load_03"],
										 [UIImage imageNamed:@"Load_04"],
										 [UIImage imageNamed:@"Load_05"],
										 [UIImage imageNamed:@"Load_06"],
                                         [UIImage imageNamed:@"Load_07"],
										 [UIImage imageNamed:@"Load_08"],
										 [UIImage imageNamed:@"Load_09"],
										 [UIImage imageNamed:@"Load_10"],
										 [UIImage imageNamed:@"Load_11"],
										 [UIImage imageNamed:@"Load_12"],
										 nil];
    
	activityImageView.animationDuration = 0.8;
	
    
	activityImageView.frame = CGRectMake(
										 self.view.frame.size.width/2
										 -statusImage.size.width/2,
										 self.view.frame.size.height/2
										 -statusImage.size.height/2,
										 statusImage.size.width,
										 statusImage.size.height);
    
	[activityImageView startAnimating];
    
	[self.view addSubview:activityImageView];
    
}

-(void)stopAnimation
{
	for (UIView *subview in [self.view subviews])
	{
		if (subview == activityImageView)
		{
			[subview removeFromSuperview];
		}
	}
}*/

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