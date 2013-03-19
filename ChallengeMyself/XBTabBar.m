//
//  XBTabBar.m
//  XB
//
//  Created by luoxubin on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XBTabBar.h"
#import "Utility.h"

// Animation
#define kAnimationDuration 0.3
// Font color and size
#define kTextColor 0xFF777777
#define kHLTextColor 0xFFFEFEFE
#define kFontSize 10
// Size
#define kButtonWidth 80.0
#define kButtonHeight 49.0
#define kButtonXOffset 80.0
#define kButtonYOffset 431.0 // Should be 480-kButtonHeight
#define kIconWidthHeight 26.0
#define kIconX 27.0
#define kIconY 5.0
#define kLabelY 33.0
#define kLabelHeight 12.0


@implementation XBTabBar
@synthesize backgroundView = m_backgroundView;
@synthesize delegate = m_delegate;
@synthesize buttons = m_buttons;

- (id)initWithFrame:(CGRect)frame buttonInfos:(NSArray *)btnInfoArray
{
    m_buttonInfo = [btnInfoArray retain];
    self = [super initWithFrame:frame];
    
    if (self)
	{
		self.backgroundColor = [UIColor clearColor];
		m_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:m_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[btnInfoArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [btnInfoArray count];
        
        m_Selection = [[UIImageView alloc]initWithFrame:CGRectMake(width * selectedTabIndex, 0, width, frame.size.height)];
        m_Selection.image = PNGImage(@"toolbar_selected_background");
        [self addSubview:m_Selection];
        
		for (int i = 0; i < [btnInfoArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
//			btn.showsTouchWhenHighlighted = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
            
            UIImageView * iconView = [[UIImageView alloc]initWithImage:[[btnInfoArray objectAtIndex:i]objectForKey:kTabButtonDefaultImage]];
            CGRect _frame = iconView.frame;
            _frame.origin.x = (width - iconView.frame.size.width)/2;
            _frame.origin.y = kIconY;
            _frame.size.width = kIconWidthHeight;
            _frame.size.height = kIconWidthHeight;
            iconView.frame = _frame;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kLabelY, width, kLabelHeight)];
            label.font = [UIFont boldSystemFontOfSize: kFontSize];
            if(selectedTabIndex == i)
            {
                label.textColor =[Utility colorWithHex:kHLTextColor];
            }
            else 
            {
                label.textColor =[Utility colorWithHex:kTextColor];
            }
            label.adjustsFontSizeToFitWidth = YES;
            label.backgroundColor = [UIColor clearColor];
            label.text = [[btnInfoArray objectAtIndex:i]objectForKey:kTabButtonTitle];
            label.textAlignment = UITextAlignmentCenter;
            
            [btn addSubview:iconView];
            [btn addSubview:label];
            [iconView release];
            [label release];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[m_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
    if(selectedTabIndex != btn.tag)
    {
         NSLog(@"Select index: %d",btn.tag);
        selectedTabIndex = btn.tag;
        [self selectTabAtIndex:btn.tag];
        if ([m_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
        {
            [m_delegate tabBar:self didSelectIndex:btn.tag];
        }

    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
    for (int i=0; i<[m_buttons count]; i++) {
        if (index == i) {
            UIButton *button = (UIButton *)[m_buttons objectAtIndex:i];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:kAnimationDuration];
            [UIView setAnimationDelay:0.0];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            m_Selection.frame = button.frame;
            [UIView commitAnimations];
            
            
            UIImage* image = [[m_buttonInfo objectAtIndex:i] objectForKey:kTabButtonSelectedImage];
            for (UIView *subView in button.subviews) 
            {
                if ([subView isKindOfClass:UIImageView.class] && subView != nil)
                {
                    ((UIImageView*)subView).image = image;
                }
                else if ([subView isKindOfClass:UILabel.class] && subView != nil)
                {
                    ((UILabel*)subView).textColor =[Utility colorWithHex:kHLTextColor];
                }
            }
            
        }else {
            UIButton *button = (UIButton *)[m_buttons objectAtIndex:i];
            UIImage *image = [[m_buttonInfo objectAtIndex:i]objectForKey:kTabButtonDefaultImage];
            for (UIView *subView in button.subviews) 
            {
                if ([subView isKindOfClass:UIImageView.class] && subView != nil)
                {
                    ((UIImageView*)subView).image = image;
                }
                else if ([subView isKindOfClass:UILabel.class] && subView != nil)
                {
                    ((UILabel*)subView).textColor =[Utility colorWithHex:kTextColor];
                }
            }
        }
    }
}

- (void)dealloc
{
    [m_backgroundView release];
    [m_buttons release];
    [m_buttonInfo release];
    [m_Selection release];
    [super dealloc];
}

@end
