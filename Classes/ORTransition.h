//
//  ORTransition.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-25.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ORNavigator.h"

@interface ORTransition : NSObject {
	NSString *name;
	NSView *toView;
	NSView *fromView;
	
	NSDictionary *transitions;
}

@property (retain) NSString *name;
@property (assign) NSView *toView;
@property (assign) NSView *fromView;
@property (retain) NSDictionary *transitions;

+ (ORTransition*) transitionNamed: (NSString*) _name;
- (void) performInNavigator: (ORNavigator*) nav;

@end
