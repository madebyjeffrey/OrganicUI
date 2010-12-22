//
//  NSBezierPath+JDAdditions.m
//  OrganicUI
//
//  Created by Jeffrey Drake on 10-12-21.
//  Copyright 2010 N/A. All rights reserved.
//

#import "NSBezierPath+JDAdditions.h"

static int quadrantBetweenPoints(NSPoint p1, NSPoint p2)
{
    NSPoint p = {p2.x - p1.x, p2.y - p1.y};
    
    if (p.x >= 0 && p.y >= 0) return 1;
    else if (p.x < 0 && p.y > 0) return 2;
    else if (p.x < 0 && p.y < 0) return 3;
    else if (p.x > 0 && p.y < 0) return 4;
    
    return 0;
}


@implementation NSBezierPath (JDAdditions)

- (void)cornerToPoint: (NSPoint)p2 radius: (CGFloat)radius
{
    const double percentage = 0.44772;
	
    NSPoint p1 = [self currentPoint];
    
    NSPoint cp1, cp2;
    
    cp1 = p1;
    cp2 = p2;
    
    switch (quadrantBetweenPoints(p1, p2))
    {
        case 1:
            cp1.x += (p2.x - p1.x) * percentage;
            cp2.y -= (p2.y - p1.y) * percentage;
            break;
            
        case 2:
            cp1.y += (p2.y - p1.y) * percentage;
            cp2.x -= (p2.x - p1.x) * percentage;
            break;
            
        case 3:
            cp1.x -= (p1.x - p2.x) * percentage;
            cp2.y += (p1.y - p2.y) * percentage;
            break;
            
        case 4:
            cp1.y -= (p1.y - p2.y) * percentage;
            cp2.x -= (p2.x - p1.x) * percentage;
            
			//        defaut:
    }
	
    [self curveToPoint: p2 controlPoint1: cp1 controlPoint2: cp2];
}

+ (NSBezierPath*) bezierPathRoundedCornersOnLeft: (NSRect) box radius: (CGFloat)r
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    NSPoint p = { box.origin.x + r, box.origin.y + box.size.height };
    [path moveToPoint: p];
    
    p = NSMakePoint(box.origin.x, box.origin.y + box.size.height - r);
    [path cornerToPoint: p radius: r];
    
    p = NSMakePoint(box.origin.x, box.origin.y + r);
    [path lineToPoint: p];
    
    p = NSMakePoint(box.origin.x + r, box.origin.y);
    [path cornerToPoint: p radius: r];
    
    p = NSMakePoint(box.origin.x + box.size.width, 
                    box.origin.y);
    [path lineToPoint: p];
    
    p = NSMakePoint(box.origin.x + box.size.width,
                    box.origin.y + box.size.height);
    
    [path lineToPoint: p];
    
    p = NSMakePoint(box.origin.x + r, box.origin.y + box.size.height);
    
    [path lineToPoint: p];
    [path closePath];
    
    return path;
}

+ (NSBezierPath*) bezierPathRoundedCornersOnRight: (NSRect) box radius: (CGFloat)r
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    NSPoint p = NSMakePoint(box.origin.x, box.origin.y + box.size.height);
    
    [path moveToPoint: p];
	
    p = NSMakePoint(box.origin.x, box.origin.y);
    [path lineToPoint: p];
    
    p = NSMakePoint(box.origin.x + box.size.width - r, box.origin.y);
    [path lineToPoint: p];
    
    
    p = NSMakePoint(box.origin.x + box.size.width,
                    box.origin.y + r);
    [path cornerToPoint: p radius: r];
    
    p = NSMakePoint(box.origin.x + box.size.width,
                    box.origin.y + box.size.height - r);
    [path lineToPoint: p];
    
    p = NSMakePoint(box.origin.x + box.size.width - r,
                    box.origin.y + box.size.height);
    
    [path cornerToPoint: p radius: r];
    
    p = NSMakePoint(box.origin.x, box.origin.y + box.size.height);
    
    [path lineToPoint: p];
    [path closePath];
    
    
    return path;
}

@end
