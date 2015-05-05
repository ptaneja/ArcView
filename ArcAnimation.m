//
//  ArcAnimation.m
//
//  Created by Pankaj Taneja on 8/12/14.
//  Copyright (c) 2014 Kaiser Permanente. All rights reserved.
//

#import "ArcAnimation.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ArcAnimation ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger arcRadius;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGFloat startingAngle;

@end

@implementation ArcAnimation

- (id)initWithContentView:(UIView *)iContentView
               centerItem:(UIView *)iCenterItem
                    items:(NSArray *)iItems
                arcRadius:(NSInteger)iRadius
            startingAngle:(CGFloat)iStartingAngle {
    
    if (self = [super init]) {
        self.contentView = iContentView;
        self.centerView = iCenterItem;
        self.items = iItems;
        self.arcRadius = iRadius;
        self.startingAngle = (iStartingAngle + 180);
        
        CGFloat totalAngle = 180;
        CGFloat delta = 0;
        
        if (self.startingAngle > 180) {
            delta = self.startingAngle - 180;
        }
        self.angle = (totalAngle - (delta * 2))/([iItems count] - 1);
    }
    return self;
}

- (void)expandArc {
    for (UIView *aView in self.items) {
        aView.hidden = NO;
        [aView setCenter:self.centerView.center];
    }
    
    [UIView animateWithDuration:.2 animations:^ {
        CGFloat increasedAngle = self.startingAngle;
        
        for (UIView *aView in self.items) {
            CGFloat angleValue = increasedAngle;
            CGPoint aFinalPoint = [self finalPointForItemWithAngle  :angleValue];
            increasedAngle = angleValue + self.angle;
            aView.alpha = 1;
            [aView setCenter:aFinalPoint];
        }
    }completion:^(BOOL iFinished) {
        
    }];
}

- (void)collapseArc {
    [UIView animateWithDuration:.3 animations:^ {
        for (UIView *aView in self.items) {
            aView.alpha = 0;
            [aView setCenter:self.centerView.center];
        }
    }completion:^(BOOL iFinished) {
        for (UIView *aView in self.items) {
            aView.hidden = YES;
        }
    }];
}

- (CGPoint)finalPointForItemWithAngle:(CGFloat)iAngle {
    CGFloat x = self.arcRadius * cos(DEGREES_TO_RADIANS(iAngle)) + self.centerView.center.x;
    CGFloat y = self.arcRadius * sin(DEGREES_TO_RADIANS(iAngle)) + self.centerView.center.y;
    return CGPointMake(x, y);
}

@end
