//
//  ORNavigator.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-22.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORNavigator.h"


@implementation ORNavigator

@synthesize ControllerStack;
@dynamic left, right, centre;

+ (ORNavigator*) navigator: (NSSize) size
{
	NSRect frame = { NSMakePoint(0, 0), size };
	
	ORNavigator *nav = [[ORNavigator alloc] initWithFrame: frame];
	
	return [nav autorelease];
}

- (id) initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame: frameRect];
	
	if (self)
	{
		self.ControllerStack = [NSMutableArray arrayWithCapacity: 5];
        [self pushController: [ORController blankControllerWithSize: frameRect.size]];
	}
	
	return self;
	
}

- (void) dealloc
{
	self.ControllerStack = nil;
	
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


@end
