/*
 *  MenuScene.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "AboutScene.h"
#import "MenuScene.h"


@implementation AboutScene

- (id) init {
    self = [super init];
    if (self != nil) {
        CCSprite * bg = [CCSprite spriteWithFile:@"menuBackground.png"];

        [bg setPosition:ccp(SCREEN_CENTER_X, SCREEN_CENTER_Y)];   
        if (IS_IPAD()) {
            bg.scale = 2.5;
        }
        [self addChild:bg z:0];
        
		al = [AboutLayer node];
        [self addChild:al z:1];
    }
	
    return self;
}

-(void) dealloc
{
    //CCLOG(@"Releasing AboutScene");
	[super dealloc];
}

@end

@implementation AboutLayer

CGPoint startTouch;
CGPoint endLocation;
float origX;
float deltaX;
float incX;
float xAtFirstTouch;
float xAtLastMove;
float menuWidth;

- (id) init {
    self = [super init];
    if (self != nil) {
        menu = [CCMenu menuWithItems:nil ];
        
        CCMenuItemImage *exitButton = [CCMenuItemImage 
                                       itemWithNormalImage:@"AboutButton.png"
                                       selectedImage:@"AboutButton.png"
                                       target:self
                                       selector:@selector(exitAbout:)];
        [menu addChild:exitButton z:30];
		[menu setAnchorPoint:ccp(0,0)];
        if (IS_IPAD()) {
            [menu setPosition:ccp(240*IPAD_MULT, 20*IPAD_MULT+IPAD_BOT_TRIM+20)]; 
        } else {
		    [menu setPosition:ccp(240, 20)];
        }
        [self addChild:menu z:50];
    
        self.isTouchEnabled = YES;
        screenIsTouched = FALSE;
        endLocation = ccp(menu.position.x, menu.position.y);
        startTouch = ccp(menu.position.x, menu.position.y);
        
        CCSprite * bg = [CCSprite spriteWithFile:@"AboutLayer.png"];
        //[bg setAnchorPoint:ccp(0,0)];
        [bg setPosition:ccp(SCREEN_CENTER_X, SCREEN_CENTER_Y)];
        [self addChild:bg z:0];
    }

    return self;
}

-(void)exitAbout: (id) sender {
	MenuScene *ms = [MenuScene node];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:0.5f scene:ms]];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	/*if (!screenIsTouched) {
		screenIsTouched = TRUE;
		CGPoint location;
		UITouch *touch = [touches anyObject];
		location = [touch locationInView: [touch view]];
		location  = [[CCDirector sharedDirector] convertToGL:location ];
        xAtFirstTouch= location.x; 
        xAtLastMove = location.x;
        origX = self.position.x;
        deltaX = 0;
        incX = 0;
	}*/
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	/*if (screenIsTouched) {
		CGPoint location;
		UITouch *touch = [touches anyObject];
		location = [touch locationInView: [touch view]];
		location  = [[CCDirector sharedDirector] convertToGL:location ];
		endLocation = location;
	    incX = location.x-xAtLastMove;
        deltaX = location.x-xAtFirstTouch;
        [self setPosition:ccp(self.position.x+incX, self.position.y)];
        xAtLastMove = location.x; 
    }*/
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	/*screenIsTouched = FALSE;
   if (self.position.x > 0) {
        [self runAction: [CCMoveTo actionWithDuration:.25 position:ccp(0, 0)]];
    } 
    if (self.position.x < -ABOUT_IMAGE_WIDTH/2) {
        [self runAction: [CCMoveTo actionWithDuration:.25 position:ccp(-ABOUT_IMAGE_WIDTH/2,0)]];
    } 
  */
}

-(void) dealloc
{ 
    //CCLOG(@"Releasing AboutLayer");
	[super dealloc];
   
}

@end
