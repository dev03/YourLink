//
//  SplashViewController.m
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import "SplashViewController.h"
#import "Globals.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

@synthesize dateLabel,versrionLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	
	NSDateFormatter *formatter;
	NSString        *dateString;
	
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"YYYY"];
	
	dateString = [formatter stringFromDate:[NSDate date]];
	
	dateLabel.text=[NSString stringWithFormat:@"\u00A9 Copyright 2014-%@",dateString];
	versrionLabel.text=versionGlobal;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
