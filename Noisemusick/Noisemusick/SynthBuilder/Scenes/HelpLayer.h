/*
 *  HelpLayer.h
 *  Drom
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Drom-LICENSE.txt," in this distribution.  */

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Control.h"

@interface HelpLayer : CCNode {
	CCMenu *img;
    float firstTouch;
    float origY;
}

@property float firstTouch;
@property float origY;

- (void) updateView:(CGPoint) location;
- (void) nothing:(id)sender;
@end
