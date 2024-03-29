//
//  MenuViewController.m
//  moi
//
//  Created by shjmun Mac on 11/11/13.
//  Copyright (c) 2013 htss. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "htssAppDelegate.h"

@interface MenuViewController ()
{
    NSArray *sosMenu,*menu,*menu2,*menu3,*Section,*sectionNames;
    htssAppDelegate *appDelegate;
}
@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (htssAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.slidingViewController setAnchorRightRevealAmount:250.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    sosMenu = [[NSArray alloc]initWithObjects:@"أغثني", nil];
    
    if ([appDelegate.userName length] != 0) {
        menu = [[NSArray alloc]initWithObjects:@"اسم المستخدم", @"لوحة الإعدادات",nil];
    }
    else
    {
        menu = [[NSArray alloc]initWithObjects:@"تسجيل الدخول" ,nil];
    }
    menu2 = [[NSArray alloc]initWithObjects:@"سفاري",@"العين الساهرة" , @"ملفي"
             ,@"تحديثات مرورية" , @"عين الطريق",nil];
    menu3 = [[NSArray alloc]initWithObjects:@"أهلا" , @"أغثني",nil];
    
    Section = [[NSArray alloc]initWithObjects:sosMenu, menu,menu2,menu3, nil];
    sectionNames = [[NSArray alloc]initWithObjects:@"وزارة الداخلية", @"معلوماتي",@"حياتي الذكية",@"سياحتي الذكية", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return Section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [menu count];
    NSArray *thisArray = [Section objectAtIndex:section];
    return thisArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSArray *thisArray = [Section objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[thisArray objectAtIndex:indexPath.row]];
    if (indexPath.section == 1 && indexPath.row == 0) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"RaratongaMask.gif"]];
        cell.textLabel.font = [UIFont fontWithName:cell.textLabel.font.fontName size:11];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionNames objectAtIndex:section];
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSArray *thisArray = [Section objectAtIndex:indexPath.section];
    NSString *identifier = [NSString stringWithFormat:@"%@", [thisArray objectAtIndex:indexPath.row]];
    if (thisArray == sosMenu) {
        [self initiateSoS];
    }else
    if (thisArray == menu) {
        NSLog(@"Identifier is: %@",identifier);
        if (appDelegate.userName.length != 0 && indexPath.row == 0) {
            
        }
    }
    else
    {
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];
    }
}

#pragma mark - htss methods

-(void)initiateSoS
{
    if (appDelegate.isSafariOn) {
        NSLog(@"Initiate Safari SoS");
    }else{
        NSLog(@"Initiate Standard SoS");
    }
}

@end
