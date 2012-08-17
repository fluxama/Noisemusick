/*
 *  NavMenu.h
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface NavMenu : CCLayer {
    bool stateOpen;
    CCMenuItemImage *showHelp;
    CCMenuItemImage *exitScene;
    CCMenuItemImage *openMenu;
}

-(void)showHelp: (id)sender;
-(void)exitScene: (id) sender;
-(void)openMenu: (id) sender;
-(void)moveToOpenState;
-(void)moveToClosedState;
@end
