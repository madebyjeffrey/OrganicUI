//
//  ORTitleBar.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-17.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ORTitleBar : NSView {
@private
    NSButton *closeButton;
    NSButton *minimizeButton;
    NSButton *zoomButton;
    NSImage *backgroundPattern;
	NSBezierPath *outline;
	NSTrackingArea *buttonArea;
}

@property (retain) NSButton *closeButton;
@property (retain) NSButton *minimizeButton;
@property (retain) NSButton *zoomButton;
@property (retain) NSImage *backgroundPattern;
@property (retain) NSBezierPath *outline;
@property (retain) NSTrackingArea *buttonArea;

- (void) updateOutline;

@end
