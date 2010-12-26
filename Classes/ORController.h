//
//  ORController.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-14.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NSColor+CGColor.h"

@interface ORController : NSObject {
@private
    NSView *view;
}

@property (retain) NSView *view;

- (id)initWithSize: (NSSize) size;
+ (ORController*) blankControllerWithSize: (NSSize) size;

@end
