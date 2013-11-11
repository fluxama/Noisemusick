/*
 *  MenuScene.h
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class MenuLayer;

@interface MenuScene : CCScene 
{
    CCMenu *menu;
    MenuLayer *ml;
}

@end

@interface MenuLayer : CCLayer 
{

	NSMutableArray *instruments;
    NSMutableArray *menuItems;
    NSMutableArray *selectedMenuItems;
	CCSprite *menu;
	float menu_x;
	float menu_y;
    float row;
    float col;
	float current_col;
    bool screenIsTouched;
}

-(void)startInstrument: (id)sender;

@end
