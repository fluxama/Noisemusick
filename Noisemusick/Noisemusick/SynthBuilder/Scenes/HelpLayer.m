/*
 *  HelpLayer.m
 *  Drom
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Drom-LICENSE.txt," in this distribution.  *///

#import "HelpLayer.h"

@implementation HelpLayer
@synthesize firstTouch;
@synthesize origY;

-(id) init {
	if( self=[super init]) {
        //img = [CCSprite spriteWithFile:@"AboutLayer.png"];
        //[self addChild:img z:100];
        CCSprite * bg = [CCSprite spriteWithFile:@"menuBackground.png"];
        [bg setPosition:ccp(SCREEN_CENTER_X, SCREEN_CENTER_Y)];
        [self addChild:bg];
        CCSprite *helpImage = [CCSprite spriteWithFile:@"AboutLayer.png"];
        [helpImage setPosition:ccp(SCREEN_CENTER_X, SCREEN_CENTER_Y)];
        [self addChild:helpImage];
	}
	return self;
}

-(void) updateView:(CGPoint) location {

}

-(void) nothing:(id)sender {
    CCLOG(@"Do nothing");
}



@end
