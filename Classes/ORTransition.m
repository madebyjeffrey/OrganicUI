//
//  ORTransition.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-25.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORTransition.h"


@implementation ORTransition

@synthesize name, toView, fromView, transitions;


+ (ORTransition*) transitionNamed: (NSString*) _name
{
	ORTransition *t = [[ORTransition alloc] init];
	
	if (t) t.name = _name;
	
	t.transitions = [NSDictionary dictionaryWithObjectsAndKeys: 
					 [NSValue valueWithPointer: @selector(slideIn:)], @"slideIn",
					 [NSValue valueWithPointer: @selector(slideOut:)], @"slideOut",
					 nil];
	
	return [t autorelease];
}

- (void) performInNavigator: (ORNavigator*) nav
{
	SEL method = [[self.transitions objectForKey: self.name] pointerValue];
	
	if (method != nil)
	{
		[self performSelector: method withObject: nav];
	}
}

- (void) slideIn: (ORNavigator*) nav
{
	self.toView.frame = nav.right;
	self.fromView.frame = nav.centre;

	[nav addSubview: self.toView];
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration: 0.7f];
	
	[[self.toView animator] setFrame: nav.centre];
	[[self.fromView animator] setFrame: nav.left];
	
	[NSAnimationContext endGrouping];
	
	[self.fromView removeFromSuperview];
}

@end
