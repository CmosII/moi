//
//  initViewController.m
//  moi
//
//  Created by shjmun Mac on 11/11/13.
//  Copyright (c) 2013 htss. All rights reserved.
//

#import "initViewController.h"
#import "htssAppDelegate.h"

@interface initViewController ()
{
    htssAppDelegate *appDelegate;
    
    IBOutlet UIButton *btnAR;
    IBOutlet UIButton *btnEN;
    
    UIAlertView *alrtCategory;
    NSUserDefaults *defaults;
}
@end

@implementation initViewController
@synthesize SegueID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    appDelegate = (htssAppDelegate*)[[UIApplication sharedApplication]delegate];
    defaults = [NSUserDefaults standardUserDefaults];
    appDelegate.userName = [defaults stringForKey:@"userName"];
    appDelegate.isAR = [defaults boolForKey:@"isAR"];
    appDelegate.userCategory = [defaults stringForKey:@"userCategory"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnARClicked:(id)sender {
    appDelegate.isAR = YES;
    
    alrtCategory = [[UIAlertView alloc]initWithTitle:@"مرحبا"
                                             message:@"تطبيق بلادي يرحب بكم ، الرجاء اختيار المسمى الأنسب لكم"
                                            delegate:self
                                   cancelButtonTitle:@"تخطي"
                                   otherButtonTitles:@"مواطن",@"مقيم",@"زائر", nil];
    
    [alrtCategory show];
    [self setDefaultforLanguageIsAR:appDelegate.isAR];
}

- (IBAction)btnENClicked:(id)sender {
    /*appDelegate.isAR = NO;
    [self setDefaultforLanguageIsAR:appDelegate.isAR];*/
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Under Construction!"
                                                   message:@"We apologize that the english feature is not available on this version, hopefully it will be added on the next update"
                                                  delegate:nil
                                         cancelButtonTitle:@"Back"
                                         otherButtonTitles:nil];
    [alert show];    
}

-(void)setDefaultforLanguageIsAR:(bool)language{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:language forKey:@"isAR"];
    [defaults synchronize];
    
    btnAR.hidden = YES;
    btnEN.hidden = YES;
}

#pragma mark -
#pragma mark UIAlertView Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alrtCategory) {
        switch (buttonIndex) {
            case 0:
                appDelegate.userCategory = @"local";
                break;
            case 1:
                appDelegate.userCategory = @"resident";
                break;
            case 2:
                appDelegate.userCategory = @"tourist";
                break;
            case 3:
                appDelegate.userCategory = @"tourist";
                break;
            default:
                break;
        }
        [defaults setObject:appDelegate.userCategory forKey:@"userCategory"];
        self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"أهلا"];
    }
}

@end