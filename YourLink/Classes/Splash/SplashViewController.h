//
//  SplashViewController.h
//  YourLink
//
//  Created by Lutful Kabir on 6/7/14.
//  Copyright (c) 2014 appiWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController
{
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *versrionLabel;
}

@property(nonatomic,retain)IBOutlet UILabel *dateLabel;
@property(nonatomic,retain)IBOutlet UILabel *versrionLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end

