//
//  ExampleAppDelegate.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-19.
//  Copyright 2010 N/A. All rights reserved.
//

#import <OrganicUI/OrganicUI.h>

#import "ExampleAppDelegate.h"



@implementation ExampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    self.window = [ORWindow quadrataWindow];
	self.window = [[[ORWindow alloc] initWithContentRect: NSMakeRect(0, 0, 580, 580)] autorelease];
    
	[self.window setTitle: @"Example"];
    [self.window makeMainWindow];
    [self.window orderFrontRegardless];
    [self.window center];
    
}

@end
