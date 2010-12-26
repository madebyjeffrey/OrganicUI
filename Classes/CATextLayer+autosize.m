//
//  CATextLayer+autosize.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-25.
//  Copyright 2010 N/A. All rights reserved.
//

#import "CATextLayer+autosize.h"

@implementation CATextLayer (autosize)

// these two methods are from Richard Hult

- (NSFont *)fontForTextLayer:(CATextLayer *)layer
{
    NSFont *font = nil;
    
    // Convert the separate font and font size to an NSFont. There are four different ways
    // to specify the font used in CATextLayer: NSFont/CTFontRef, NSString, CGFontRet.
    if ([(id)layer.font isKindOfClass:[NSFont class]]) {
        font = [NSFont fontWithName:[(NSFont *)layer.font fontName] size:layer.fontSize];
    }
    else if ([(id)layer.font isKindOfClass:[NSString class]]) {
        font = [NSFont fontWithName:(NSString *)layer.font size:layer.fontSize];
    } else {
        CFTypeID typeID = CFGetTypeID(layer.font);
        if (typeID == CGFontGetTypeID()) {
            // ... we ignore this here, could be implemented later.
        }
    }
    
    return font;
}

- (NSAttributedString *)attributedStringForTextLayer:(CATextLayer *)layer
{
    // We have two different cases, self.string can be either an NSString or NSAttributedString.
    // Those need to be handled differently, as the font/fontSize properties are not used in
    // in the attributed string case.
    
    if ([layer.string isKindOfClass:[NSAttributedString class]]) {
        return layer.string;
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[self fontForTextLayer:layer]
                                                           forKey:NSFontAttributeName];
    
    return [[[NSAttributedString alloc] initWithString:layer.string
                                            attributes:attributes] autorelease];
}


- (void) autosize
{
    NSAttributedString *string = [self attributedStringForTextLayer: self];
//    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)string);

	NSSize s = [string size];
	
	self.bounds = CGRectMake(0, 0, s.width, s.height);
}
/*
- (CGSize)frameSizeForTextLayer:(CATextLayer *)layer
{
    NSAttributedString *string = [self attributedStringForTextLayer:layer];
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGFloat width = layer.bounds.size.width;
    
    CFIndex offset = 0, length;
    CGFloat y = 0;
    do {
        length = CTTypesetterSuggestLineBreak(typesetter, offset, width);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(offset, length));
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CFRelease(line);
        
        offset += length;
        y += ascent + descent + leading;
    } while (offset < [string length]);
    
    CFRelease(typesetter);
    
    return CGSizeMake(width, ceil(y));
}
*/
@end
