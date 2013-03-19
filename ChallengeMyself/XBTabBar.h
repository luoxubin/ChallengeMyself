//
//  XBTabBar.h
//  XB
//
//  Created by luoxubin on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eSpeedTab = 0,
    eMemoryTab,
    EHabitTab,
    eMoreButton,
    eNilButton
}ENMTabIndex;


@protocol XBTabBarDelegate;

@interface XBTabBar : UIView
{
	UIImageView *m_backgroundView;
	id<XBTabBarDelegate> m_delegate;
	NSMutableArray *m_buttons;
    NSArray *m_buttonInfo;
    ENMTabIndex selectedTabIndex;
    UIImageView *m_Selection;
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, assign) id<XBTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;


- (id)initWithFrame:(CGRect)frame buttonInfos:(NSArray *)btnInfoArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)setBackgroundImage:(UIImage *)img;
@end
@protocol XBTabBarDelegate<NSObject>
@optional
- (void)tabBar:(XBTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
