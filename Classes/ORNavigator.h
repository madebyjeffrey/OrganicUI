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
	NSMutableArray *controllers;
	ORController *root;
}

@property (retain) NSMutableArray *controllers;
@property (retain) ORController *root;

@property (readonly) NSRect left;
@property (readonly) NSRect right;
@property (readonly) NSRect centre;

+ (ORNavigator*) navigator: (NSSize) size rootController: (ORController*) controller;

- (void) pushController:(ORController *)controller transition: (NSString*) transition;
- (ORController*) popController;



@end
