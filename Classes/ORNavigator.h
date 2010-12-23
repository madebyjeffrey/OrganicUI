//
//  ORNavigator.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-22.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ORController.h"

@interface ORNavigator : NSView {
@private
	NSMutableArray *ControllerStack;
}

@property (retain) NSMutableArray *ControllerStack;
@property (readonly) NSRect left;
@property (readonly) NSRect right;
@property (readonly) NSRect centre;

+ (ORNavigator*) navigator: (NSSize) size;

- (void) pushController: (ORController*) controller;
- (ORController*) popController;

@end
