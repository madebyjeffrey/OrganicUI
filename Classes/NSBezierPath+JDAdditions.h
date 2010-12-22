//
//  NSBezierPath+JDAdditions.h
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-21.
//  Copyright 2010 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface  NSBezierPath (JDAdditions)

- (void)cornerToPoint: (NSPoint)p2 radius: (CGFloat)radius;
+ (NSBezierPath*) bezierPathRoundedCornersOnLeft: (NSRect) box radius: (CGFloat)r;
+ (NSBezierPath*) bezierPathRoundedCornersOnRight: (NSRect) box radius: (CGFloat)r;

@end