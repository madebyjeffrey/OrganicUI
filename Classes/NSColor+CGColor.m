//
//  NSColor+CGColor.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-11-15.
//  Copyright 2010 N/A. All rights reserved.
//

#import "NSColor+CGColor.h"

@implementation NSColor (CGColor)

@dynamic CGColor;

- (CGColorRef) CGColor
{
    CGColorSpaceRef colorspace = [[self colorSpace] CGColorSpace];
    const NSInteger nComponents = [self numberOfComponents];
    
    CGFloat components[nComponents];
    
    [self getComponents: components];
    
    CGColorRef c = CGColorCreate(colorspace, components);
        
    return (CGColorRef)[(id)c autorelease];
}

@end
