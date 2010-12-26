//
//  ORNavigator.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-22.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORNavigator.h"

#import "ORTransition.h"

@implementation ORNavigator

@synthesize controllers, root;

@dynamic left, right, centre;

+ (ORNavigator*) navigator: (NSSize) size rootController: (ORController*) controller
{
	NSRect frame = { NSMakePoint(0, 0), size };
	
	ORNavigator *nav = [[ORNavigator alloc] initWithFrame: frame];
	if (nav)
	{
		nav.root = controller;
		[nav pushController: nav.root transition: nil];
	}
	
	return [nav autorelease];
}


- (id) initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame: frameRect];
	
	if (self)
	{
		self.controllers = [NSMutableArray arrayWithCapacity: 5];
//
	}
	
	return self;
	
}

- (void) dealloc
{
	self.controllers = nil;
	
	[super dealloc];
}

- (NSRect) left
{
	NSRect frame = [self frame];
	
	frame.origin = NSMakePoint(-frame.size.width, 0);
	
	return frame;
}

- (NSRect) right
{
	NSRect frame = [self frame];
	
	frame.origin = NSMakePoint(frame.size.width, 0);
	
	return frame;	
}

- (NSRect) centre
{
	NSRect frame = [self frame];
	frame.origin = NSMakePoint(0, 0);
	
	return frame;
}

- (void) pushController:(ORController *)controller transition: (NSString*) transition
{
	if ((controller == self.root) && ([self.controllers count]==0))
	{
		controller.view.frame = self.centre;
		[self addSubview: controller.view];
		[self.controllers addObject: 
		 [NSDictionary dictionaryWithObjectsAndKeys: controller, @"controller", transition, @"transition", nil]];
		return;
	}
	
	[self.controllers addObject:
	 [NSDictionary dictionaryWithObjectsAndKeys: controller, @"controller", transition, @"transition", nil]];
	
	ORTransition *tran = [ORTransition transitionNamed: transition];
	
	tran.toView = controller.view;
	NSDictionary *from = [self.controllers objectAtIndex: [self.controllers count]-2];
	tran.fromView = [[from objectForKey: @"controller"] view];
	
	[tran performInNavigator: self];
	
	
}

- (ORController*) popController
{
	return nil;
}
/*
- (void) pushController: (ORController*) controller
{
    // check for initialization
    if ([self.ControllerStack count] == 0) 
    {
        [self.ControllerStack addObject: controller];
        [self addSubview: controller.view];
        
        return;
    }
    
    
    ORController *controllerOut = [self.ControllerStack lastObject];
    
    [self.ControllerStack addObject: controller];
    
    // will animate out the current, and animate in the new at the same time
    // controllerOut is assumed to be in the contentView visible 
    
    // add new controller to the right of the screen
    
    [controller.view setFrame: self.right];
    [self addSubview: controller.view];
	
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration: 0.7f];
    
    // slide old view out
    [[controllerOut.view animator] setFrame: self.left];
    
    // slide new view in
    [[controller.view animator] setFrame: self.centre];   
    
    [NSAnimationContext endGrouping];
	
	[controllerOut.view removeFromSuperview];
    
}

- (ORController*) popController
{
    if ([self.ControllerStack count] < 1)
    {
        @throw [NSException exceptionWithName: @"NoControllerToPop" reason:@"There are no more controllers to pop." userInfo: nil];
    }
    
    ORController *controllerOut = [self.ControllerStack lastObject];
    [self.ControllerStack removeLastObject];
    
    ORController *controllerIn = ([self.ControllerStack count] < 1
								  ? [ORController blankControllerWithSize: self.frame.size]
								  : [self.ControllerStack lastObject]);
    
    [controllerIn.view setFrame: self.left];
    [self addSubview: controllerIn.view];
    
    [controllerOut.view setFrame: self.centre];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration: 0.7f];
    
    // slide old view out
    [[controllerOut.view animator] setFrame: self.right];
    
    // slide new view in
    [[controllerIn.view animator] setFrame: self.centre];   
    
    [NSAnimationContext endGrouping];
	
	[controllerOut.view removeFromSuperview];
    
    return controllerOut;
}

*/
@end
