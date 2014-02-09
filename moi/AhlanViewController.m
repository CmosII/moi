//
//  AhlanViewController.m
//  moi
//
//  Created by shjmun Mac on 11/11/13.
//  Copyright (c) 2013 htss. All rights reserved.
//

#import "AhlanViewController.h"
#import "htssAppDelegate.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface AhlanViewController ()
{
    htssAppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UILabel *lblLang;
@end

@implementation AhlanViewController
@synthesize btnMenu;

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
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 0.75f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(8, 10, 34, 24);
    [btnMenu setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnMenu];
    
    if (appDelegate.isAR) {
        _lblLang.text = @"عربي";
    }else{
        _lblLang.text = @"English";
    }
}

-(IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LogOut"]) {
        appDelegate.userName = @"";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:appDelegate.userName forKey:@"userName"];
        [defaults synchronize];
    }else if ([[segue identifier] isEqualToString:@"LogIn"]) {
        appDelegate.userName = @"hamad.theyab@htss.ae";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:appDelegate.userName forKey:@"userName"];
        [defaults synchronize];
    }
}

#pragma mark -
#pragma mark htss methods

- (IBAction)logInClicked:(id)sender {
    [self performSegueWithIdentifier:@"LogIn" sender:self];
}

- (IBAction)logOutClicked:(id)sender {
     [self performSegueWithIdentifier:@"LogOut" sender:self];
}

@end
