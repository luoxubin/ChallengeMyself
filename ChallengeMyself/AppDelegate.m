//
//  AppDelegate.m
//  ChallengeMyself
//
//  Created by luoxubin on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "XBTabBarController.h"
#import "XBNavigationController.h"

#define kAnimation1Step @"SplashAnimation1"
#define kAnimation2Step @"SplashAnimation2"
#define kSplashYPosition 480
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController;




- (void)dealloc
{
    [_window release];
    [splashWindow release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [self setUpSplashWindow];
    [self setUpTabControllers];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    [self startSplashAnimation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

-(void)SetViewTop:(UIView*)view top:(int)y
{
    CGRect origin = view.frame;
    view.frame = (CGRect){origin.origin.x,y,origin.size.width,origin.size.height};
}


- (void)startSplashAnimation
{
    //window.userInteractionEnabled = NO;
    [UIView beginAnimations:kAnimation1Step context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:0.1];
    [self SetViewTop:_window top:kSplashYPosition];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:kAnimation1Step])
    {
        _window.userInteractionEnabled = YES;
        [UIView beginAnimations:kAnimation2Step context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.85];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [self SetViewTop:splashWindow top:-kSplashYPosition];
        [self SetViewTop:_window top:0];
        [UIView commitAnimations];        
    }
}

-(void)setUpTabControllers
{
    XBNavigationController *firstVC = [[XBNavigationController alloc] init];
    firstVC.title = NSLocalizedString(@"kTabbarSpeed",nil);
    XBUINavigationController * rootnc1 = [[XBUINavigationController alloc]initWithRootViewController:firstVC];
    [firstVC release];
    
    XBNavigationController *sencdVC = [[XBNavigationController alloc] init];
    sencdVC.title = NSLocalizedString(@"kTabbarMemory",nil);
    XBUINavigationController * rootnc2 = [[XBUINavigationController alloc]initWithRootViewController:sencdVC];
    [sencdVC release];
    
    XBNavigationController *thirdVC = [[XBNavigationController alloc] init];
    thirdVC.title = NSLocalizedString(@"kTabbarHabit",nil);
    XBUINavigationController *rootc3 = [[XBUINavigationController alloc]initWithRootViewController:thirdVC];
    [thirdVC release];
    
    XBNavigationController *forthVC = [[XBNavigationController alloc] init];
    forthVC.title = NSLocalizedString(@"kTabbarMore",nil);
    XBUINavigationController *rootc4 = [[XBUINavigationController alloc]initWithRootViewController:forthVC];
    [forthVC release];
    
	NSArray *ctrlArr = [NSArray arrayWithObjects:rootnc1,rootnc2,rootc3,rootc4,nil];
	[rootnc1 release];
    [rootnc2 release];
	[rootc3 release];
    [rootc4 release];
    
	NSMutableDictionary *btnInfo1 = [NSMutableDictionary dictionaryWithCapacity:3];
	[btnInfo1 setObject:PNGImage(@"toolbar_button_home") forKey:kTabButtonDefaultImage];
	[btnInfo1 setObject:PNGImage(@"toolbar_button_home_selected") forKey:kTabButtonSelectedImage];
    [btnInfo1 setObject:NSLocalizedString(@"kTabbarSpeed",nil) forKey:kTabButtonTitle];
    NSMutableDictionary *btnInfo2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[btnInfo2 setObject:PNGImage(@"toolbar_button_channel") forKey:kTabButtonDefaultImage];
	[btnInfo2 setObject:PNGImage(@"toolbar_button_channel_selected") forKey:kTabButtonSelectedImage];
    [btnInfo2 setObject:NSLocalizedString(@"kTabbarMemory",nil) forKey:kTabButtonTitle];
    NSMutableDictionary *btnInfo3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[btnInfo3 setObject:PNGImage(@"toolbar_button_search") forKey:kTabButtonDefaultImage];
	[btnInfo3 setObject:PNGImage(@"toolbar_button_search_selected") forKey:kTabButtonSelectedImage];
    [btnInfo3 setObject:NSLocalizedString(@"kTabbarHabit",nil) forKey:kTabButtonTitle];
    NSMutableDictionary *btnInfo4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[btnInfo4 setObject:PNGImage(@"toolbar_button_more") forKey:kTabButtonDefaultImage];
	[btnInfo4 setObject:PNGImage(@"toolbar_button_more_selected") forKey:kTabButtonSelectedImage];
    [btnInfo4 setObject:NSLocalizedString(@"kTabbarMore",nil) forKey:kTabButtonTitle];
    
	NSArray *btnInfoArr = [NSArray arrayWithObjects:btnInfo1,btnInfo2,btnInfo3,btnInfo4,nil];
	
	self.tabBarController = [[XBTabBarController alloc] initWithViewControllers:ctrlArr btnInfoArray:btnInfoArr];
	[self.tabBarController.tabBar setBackgroundImage:PNGImage(@"toolbar_background")];
	[self.tabBarController setTabBarTransparent:NO];
}
-(void)setUpSplashWindow
{
    splashWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView* defaultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    defaultView.frame = CGRectMake(0, 20, 320, 460);
    [splashWindow addSubview:defaultView];
    [defaultView release];
    [splashWindow makeKeyAndVisible];
}


@end
