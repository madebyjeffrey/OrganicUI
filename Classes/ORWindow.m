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
		
		CALayer *mask = [CALayer layer];
		mask.backgroundColor = [NSColor blackColor].CGColor;
		mask.cornerRadius = 6;
		[mask removeFromSuperlayer];
		
		[[self contentView] makeBackingLayer];
		[[self contentView] layer].mask = mask;
		[[self contentView] layer].masksToBounds = YES;
		
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

- (BOOL)acceptsMouseMovedEvents
{
	return YES;
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

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (BOOL) canBecomeMainWindow
{
    return YES;
}

- (void)dealloc {
    [backgroundPattern release];
    
    [super dealloc];
}
@end
