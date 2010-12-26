//
//  ORWindow.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-11-16.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ORTitleBar.h"
#import "NSColor+CGColor.h"

//#import "MainMenuController.h"


@interface ORWindow : NSWindow {
@private
  //  NSMutableArray *ControllerStack;
    NSColor *backgroundPattern;
    ORTitleBar *windowTitleBar;
}

//@property (retain) NSMutableArray *ControllerStack;
@property (readonly) NSColor *backgroundPattern;
@property (retain) ORTitleBar *windowTitleBar;

/*- (void) pushController: (ORController*) controller;
- (ORController*) popController;  */
- (id) initWithContentRect:(NSRect)contentRect;
- (NSColor*) background;
- (id) initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;
@end
