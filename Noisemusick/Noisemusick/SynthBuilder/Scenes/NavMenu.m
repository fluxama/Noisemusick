/*
 *  NavMenu.m
 *  Noisemusick 
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Drom-LICENSE.txt," in this distribution.  */


#import "NavMenu.h"
#import "MenuScene.h"
#import "InstrumentScene.h"

@implementation NavMenu

- (id) init {
    self = [super init];
    if (self != nil) {
        // Create pull down navigation menu
        
        stateOpen = FALSE;
        
        CCMenu *nav_menu = [CCMenu menuWithItems:nil ];
        
        openMenu = [CCMenuItemImage 
                    itemWithNormalImage:@"navMenuSlide.png"
                    selectedImage:@"navMenuSlide.png"
                    target:self
                    selector:@selector(openMenu:)];
    
        exitMenu = [CCMenuItemImage 
                    itemWithNormalImage:@"navMenuExit.png"
                    selectedImage:@"navMenuExit.png"
                    target:self
                    selector:@selector(exitMenu:)];
        
        showHelp = [CCMenuItemImage 
                     itemWithNormalImage:@"navMenuHelp.png"
                     selectedImage:@"navMenuHelp.png"
                     target:self
                     selector:@selector(showHelp:)];
        
        showInfo = [CCMenuItemImage 
                    itemWithNormalImage:@"navMenuInfo.png"
                    selectedImage:@"navMenuInfo.png"
                    target:self
                    selector:@selector(showInfo:)];

        //[showHelp setPosition:ccp(25, 169)];
        //[closeScene setPosition:ccp(25, 85)];
        //[openMenu setPosition:ccp(25, 40)];
        [nav_menu addChild:openMenu];
        [nav_menu addChild:exitMenu];
        [nav_menu addChild:showHelp];
        [nav_menu addChild:showInfo];

        [nav_menu alignItemsHorizontallyWithPadding:3];
        [nav_menu setAnchorPoint:ccp(0.5, 0)];
        
        CCSprite * nav_bg = [CCSprite spriteWithFile:@"navMenuBg.png"];
        [nav_menu setPosition:ccp(nav_bg.contentSize.width/2, nav_bg.contentSize.height/2)];
        [nav_bg addChild:nav_menu];
        
        [self addChild:nav_bg z:49];
        
        
    }
    return self;
}

-(void)showHelp: (id)sender {
    [(InstrumentLayer *)self.parent toggleHelp:0];
    [self moveToClosedState];
}

-(void)showInfo: (id) sender{
    [(InstrumentScene *)self.parent toggleInfo:0];
    [self moveToClosedState];
}

-(void)openMenu: (id) sender{
    //CCLOG(@"Open menu");
    if (stateOpen) {
        [self moveToClosedState];
    } else {
        [self moveToOpenState];
    }
}

-(void)exitMenu: (id) sender {
        MenuScene *ms = [MenuScene node];
        [[CCDirector sharedDirector] replaceScene:ms];
}

-(void)moveToOpenState {
    //CCLOG(@"Move to Open");
    if (IS_IPAD) {
        [self runAction: [CCMoveBy actionWithDuration:.25 position:ccp(-134,0)]];
    } else {
        [self runAction: [CCMoveBy actionWithDuration:.25 position:ccp(-105,0)]];
    }
    [openMenu runAction: [CCRotateBy actionWithDuration:.5 angle:180]];
    stateOpen = TRUE;
}

-(void)moveToClosedState {
    //CCLOG(@"Move to Closed");
    if (IS_IPAD) {
        [self runAction: [CCMoveBy actionWithDuration:.25 position:ccp(134,0)]];
    } else {
        [self runAction: [CCMoveBy actionWithDuration:.25 position:ccp(105,0)]];
    }
    [openMenu runAction: [CCRotateBy actionWithDuration:.5 angle:-180]];
    stateOpen = FALSE;
}

-(void) dealloc {
    
    [super dealloc];
}

@end