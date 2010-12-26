//
//  ORTitleBar.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-17.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORTitleBar.h"
#import "NSBezierPath+JDAdditions.h"

@implementation ORTitleBar

@synthesize zoomButton, closeButton, minimizeButton, backgroundPattern;
@synthesize outline, buttonArea;

- (BOOL)_mouseInGroup:(id)sender
{
	return [self mouse:
			[self convertPoint:[[self window] mouseLocationOutsideOfEventStream]
					  fromView:nil]
				inRect:[self.buttonArea rect]];
}

- (BOOL)mouseDownCanMoveWindow
{
	return YES;
	/*
	([self mouse: [self convertPoint:[[self window] mouseLocationOutsideOfEventStream]
						  fromView:nil]
			 inRect: [self.closeButton frame]]) ||
	([self mouse: [self convertPoint:[[self window] mouseLocationOutsideOfEventStream]
							fromView:nil]
		  inRect: [self.zoomButton frame]]) ||
	([self mouse: [self convertPoint:[[self window] mouseLocationOutsideOfEventStream]
							fromView:nil]
		  inRect: [self.minimizeButton frame]]);
*/
}

- (id)initWithFrame:(NSRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.closeButton = [NSWindow standardWindowButton: NSWindowCloseButton 
                                             forStyleMask:NSTexturedBackgroundWindowMask];
        self.minimizeButton = [NSWindow standardWindowButton: NSWindowMiniaturizeButton 
                                                forStyleMask:NSTexturedBackgroundWindowMask];
        self.zoomButton = [NSWindow standardWindowButton: NSWindowZoomButton 
                                            forStyleMask:NSTexturedBackgroundWindowMask];
        NSRect __bounds = [self bounds];
        NSRect __frame = [self.closeButton frame];
        __frame.origin.x = 8;
        __frame.origin.y = 21-__bounds.size.height+3;
        
        [self.closeButton setFrame: __frame];
        
        __frame = [self.minimizeButton frame];
        __frame.origin.x = 8+21;
        __frame.origin.y = 21-frame.size.height + 3;
        [self.minimizeButton setFrame: __frame];
        
        __frame = [self.zoomButton frame];
        __frame.origin.x = 8+21+21;
        __frame.origin.y = 21-frame.size.height + 3;
        [self.zoomButton setFrame: __frame];

        [self addSubview: self.closeButton];
        [self addSubview: self.minimizeButton];
        [self addSubview: self.zoomButton];
		
		NSRect bound = [self.closeButton frame];
		bound.size.width = [self.zoomButton frame].origin.x 
						 + [self.zoomButton frame].size.width;
		
		NSTrackingArea *trackingButtons = [[NSTrackingArea alloc] initWithRect: bound
																	   options: NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow
																		 owner: self 
																	  userInfo: nil];
		
		[self addTrackingArea: trackingButtons];
		
		self.buttonArea = trackingButtons;
     
		[self updateOutline];
    }
    
    return self;
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	NSTrackingArea *area = nil;
	
	@try {
		area = [theEvent trackingArea];
		
		if (area == self.buttonArea)
		{
			[self.closeButton setNeedsDisplay: YES];
			[self.minimizeButton setNeedsDisplay: YES];
			[self.zoomButton setNeedsDisplay: YES];
		}
	}
	@catch (NSException * e) {
		// not a tracking area event
	}
}

- (void)dealloc {
    // Clean-up code here.
    self.backgroundPattern = nil;
    
    [super dealloc];
}

// This method should be called when the window resizes
- (void) updateOutline
{
	NSRect __frame = [self bounds];

    const int radius = 6;
    NSBezierPath *background = [NSBezierPath bezierPath];
    [background moveToPoint: NSMakePoint(0, 0)];
    [background lineToPoint: NSMakePoint(__frame.size.width, 0)];
	
    [background lineToPoint: NSMakePoint(__frame.size.width, __frame.size.height-radius)];
    [background cornerToPoint: NSMakePoint(__frame.size.width - radius, __frame.size.height) radius: radius];
    
    [background lineToPoint: NSMakePoint(radius, __frame.size.height)];
    [background cornerToPoint: NSMakePoint(0, __frame.size.height-radius) radius: radius];
    
    [background lineToPoint: NSMakePoint(0, 0)];
    [background closePath];
	
	self.outline = background;
}

- (void)drawRect:(NSRect)dirtyRect {
    
	
	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceRed: 0.55 green: 0.55 blue:0.55 alpha:1] 
                                                         endingColor: [NSColor colorWithDeviceRed: 0.2 green:0.2 blue:0.2 alpha:1]];

    [gradient drawInBezierPath: self.outline  angle: 270];
    [gradient release];
    
    [[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1.0] setStroke];
    
    [self.outline stroke];
    

	// The following code is borrowed from somewhere, but I forget where.
	// Probably will change this to something better.
	
    NSWindow *win = [self window];
    NSString *title = (win? [win title] : @"");

    NSFont *titleFont = [NSFont titleBarFontOfSize: 0];
    NSMutableParagraphStyle *paraStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
    [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    [paraStyle setAlignment:NSCenterTextAlignment];
    [paraStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										titleFont, NSFontAttributeName,
										[NSColor whiteColor], NSForegroundColorAttributeName,
                                       [[paraStyle copy] autorelease], NSParagraphStyleAttributeName,
                                       nil];
    
    NSSize titleSize = [title sizeWithAttributes:titleAttrs];
    // We vertically centre the title in the titlbar area, and we also horizontally 
    // inset the title by 19px, to allow for the 3px space from window's edge to close-widget, 
    // plus 13px for the close widget itself, plus another 3px space on the other side of 
    // the widget.
    NSRect titleRect = NSInsetRect([self bounds], 200, ([self bounds].size.height - titleSize.height) / 2.0);
    [title drawInRect:titleRect withAttributes:titleAttrs];


}

@end
