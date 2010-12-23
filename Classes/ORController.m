//
//  ORController.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-14.
//  Copyright 2010 N/A. All rights reserved.
//

#import "ORController.h"


@implementation ORController

@synthesize view;

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithSize: (NSSize) size;
{
	return nil; // no implementation
}

- (void)dealloc {
    self.view = nil;
    
    [super dealloc];
}

+ (ORController*) blankControllerWithSize: (NSSize) size
{
    ORController *controller = [ORController new];
 
    NSLog(@"blank controller retrieved");
    
    NSView *_view = [[NSView alloc] initWithFrame: NSMakeRect(0, 0, size.width, size.height)];
        
    [_view setWantsLayer: YES];
    
    _view.layer.backgroundColor = [NSColor blackColor].CGColor;
    [_view autorelease];
    
    controller.view = _view;
    
    return [controller autorelease];
}

@end
