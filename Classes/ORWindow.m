//
//  ORWindow.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-11-16.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORWindow.h"


@implementation ORWindow

//@synthesize ControllerStack, 
@synthesize windowTitleBar;
@dynamic backgroundPattern;

- (id) initWithContentRect:(NSRect)contentRect 
{
	self = [self initWithContentRect: contentRect styleMask: 0 backing: 0 defer: NO];
	
	return self;
}

- (id) initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag	
{
	self = [super initWithContentRect: contentRect styleMask: NSBorderlessWindowMask backing: NSBackingStoreBuffered defer: NO];

	if (self)
	{
		[self setBackgroundColor: [NSColor clearColor]];
		[self setAlphaValue:1.0];
		[self setHasShadow: YES];
		[self setOpaque: NO];
		[self setMovableByWindowBackground:YES];
        
		[self setBackgroundColor: self.background];
		
		NSRect frame = [self frame];
		self.windowTitleBar = [[[ORTitleBar alloc] 
								initWithFrame: NSMakeRect(0, frame.size.height - 21,
														  frame.size.width, 21)] autorelease];
		
		[[self contentView] addSubview: self.windowTitleBar 
							positioned: NSWindowAbove
							relativeTo: nil];
		
		[self.windowTitleBar setHidden: YES];
		
		NSTrackingArea *titlebar = [[[NSTrackingArea alloc] initWithRect: [self.windowTitleBar frame] 
																 options: NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInActiveApp 
																   owner: self 
																userInfo: nil] autorelease];
		
		[[self contentView] addTrackingArea: titlebar];
		
		[self setAcceptsMouseMovedEvents:YES];
		
	}
	
	return self;
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [self.windowTitleBar setAlphaValue: 0.0];
    [self.windowTitleBar setHidden: NO];
    [[self.windowTitleBar animator] setAlphaValue: 1.0];

}

- (void)mouseExited:(NSEvent *)theEvent
{
    [[self.windowTitleBar animator] setAlphaValue: 0.0];
    
    [[self.windowTitleBar animator] setHidden: YES];
    [self.windowTitleBar setAlphaValue: 1.0];

}

- (NSColor*) background
{
    static bool initialized = NO;
    
    if (initialized == YES)
        return backgroundPattern;
    
    NSImage *_background = [[NSImage alloc] initWithSize: [self frame].size];
    
    [_background lockFocus];
    
    NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRoundedRect: [self frame] xRadius: 6 yRadius: 6];
    
    [[NSColor blackColor] setFill];
    [[NSColor blackColor] setStroke];
    
    [backgroundPath stroke];
    [backgroundPath fill];
    
    [_background unlockFocus];
    
    backgroundPattern = [NSColor colorWithPatternImage: [_background autorelease]];
    
    [backgroundPattern retain];
    
    initialized = YES;
    
    return backgroundPattern;
}

//- (void) awakeFromNib
//{
/*    self.ControllerStack = [NSMutableArray arrayWithCapacity: 3];
    
    [self pushController: [ORController blankController]];
    
    MainMenuController *mainMenu = [[[MainMenuController alloc] init] autorelease];
    
    [self pushController: mainMenu];
    
  */  
    
    

//}

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (BOOL) canBecomeMainWindow
{
    return YES;
}

- (void)dealloc {
//    self.ControllerStack = nil;
    [backgroundPattern release];
    
    [super dealloc];
}

/*
- (void) pushController: (ORController*) controller
{
    // check for initialization
    if ([self.ControllerStack count] == 0) 
    {
        [self.ControllerStack addObject: controller];
        [[self contentView] addSubview: controller.view];
        
        return;
    }
    
    
    ORController *controllerOut = [self.ControllerStack lastObject];
    
    [self.ControllerStack addObject: controller];
    
    // will animate out the current, and animate in the new at the same time
    // controllerOut is assumed to be in the contentView visible 
    
    // add new controller to the right of the screen
    
    [controller.view setFrame: NSMakeRect(480, 0, 480, 480)];
    [[self contentView] addSubview: controller.view];

    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration: 0.7f];
    
    // slide old view out
    [[controllerOut.view animator] setFrame: NSMakeRect(-480, 0, 480, 480)];
    
    // slide new view in
    [[controller.view animator] setFrame: NSMakeRect(0, 0, 480, 480)];   
    
    [NSAnimationContext endGrouping];
    
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
                                ? [ORController blankController]
                                : [self.ControllerStack lastObject]);
    
    [controllerIn.view setFrame: NSMakeRect(-480, 0, 480, 480)];
    [[self contentView] addSubview: controllerIn.view];
    
    [controllerOut.view setFrame: NSMakeRect(0, 0, 480, 480)];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration: 0.7f];
    
    // slide old view out
    [[controllerOut.view animator] setFrame: NSMakeRect(480, 0, 480, 480)];
    
    // slide new view in
    [[controllerIn.view animator] setFrame: NSMakeRect(0, 0, 480, 480)];   
    
    [NSAnimationContext endGrouping];
    
    return controllerOut;
}
*/
@end
