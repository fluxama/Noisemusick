/*
 *  MenuScene.h
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class AboutLayer;

@interface AboutScene : CCScene 
{
    AboutLayer *al;
}

@end

@interface AboutLayer : CCLayer 
{
	CCMenu *menu;
	float menu_x;
	float menu_y;
    float row;
    float col;
	float current_col;
    bool screenIsTouched;
}

-(void)exitAbout: (id) sender;

@end
