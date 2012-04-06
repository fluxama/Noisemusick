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
#import "AboutScene.h"

@class MenuLayer;

@interface MenuScene : CCScene 
{
    CCMenu *menu;
    MenuLayer *ml;
}

-(void)toggleAbout: (id) sender;

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
