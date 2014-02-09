//
//  htssAppDelegate.h
//  moi
//
//  Created by shjmun Mac on 11/11/13.
//  Copyright (c) 2013 htss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface htssAppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL isAR;
    
    NSString *userName;
    NSString *userCategory;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readwrite) BOOL isAR;
@property (nonatomic, readwrite) BOOL isSafariOn;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *userCategory;
@end
