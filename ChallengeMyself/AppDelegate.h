//
//  AppDelegate.h
//  ChallengeMyself
//
//  Created by luoxubin on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow* splashWindow;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain)XBTabBarController* tabBarController;

-(void)SetViewTop:(UIView*)view top:(int)y;
- (void)startSplashAnimation;
-(void)setUpTabControllers;
-(void)setUpSplashWindow;

@end
