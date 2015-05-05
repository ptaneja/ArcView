//
//  ArcAnimation.h
//
//  Created by Pankaj Taneja on 8/12/14.
//  Copyright (c) 2014 Kaiser Permanente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArcAnimation : NSObject

- (id)initWithContentView:(UIView *)iContentView
               centerItem:(UIView *)iCenterItem
                    items:(NSArray *)iItems
                arcRadius:(NSInteger)iRadius
            startingAngle:(CGFloat)iStartingAngle;

- (void)expandArc;

- (void)collapseArc;

@end
