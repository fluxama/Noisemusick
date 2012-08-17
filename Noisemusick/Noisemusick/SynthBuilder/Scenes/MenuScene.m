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


#import "MenuScene.h"
#import "InstrumentScene.h"
#import "AboutScene.h"

@implementation MenuScene

- (id) init {
    self = [super init];
    if (self != nil) {
        CCSprite * bg = [CCSprite spriteWithFile:@"menuBackground.png"];
        [bg setPosition:ccp(SCREEN_CENTER_X, SCREEN_CENTER_Y)];
        if (IS_IPAD()) {
            bg.scale = 2.5; 
        }
        [self addChild:bg z:0];
        
		ml = [MenuLayer node];
        [self addChild:ml z:1];
        menu = [CCMenu menuWithItems:nil ];

        /*CCMenuItemImage *aboutButton = [CCMenuItemImage 
                                        itemWithNormalImage:@"IconInfo.png"
                                        selectedImage:@"IconInfo.png"
                                        target:self
                                        selector:@selector(toggleAbout:)];
        
        [aboutButton setPosition:ccp(SCREEN_CENTER_X, BUTTON_Y)];

        [menu addChild:aboutButton z:30];        
		[menu setAnchorPoint:ccp(0,0)];
		[menu setPosition:ccp(0, 0)];

        [self addChild:menu z:50];
         */
        
    }
	
    return self;
}

-(void) toggleAbout: (id) sender {
    //CCLOG(@"about pressed");
    AboutScene *as = [AboutScene node];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFlipY transitionWithDuration:0.5f scene:as]];
}

-(void) dealloc
{
    //CCLOG(@"Releasing MenuScene");
	[super dealloc];
}

@end

@implementation MenuLayer

CGPoint startTouch;
CGPoint endLocation;
float origX;
float deltaX;
float incX;
float xAtFirstTouch;
float xAtLastMove;
float menuWidth;
int selected;
bool startedMoveTo;
bool waitForMoveTo;

- (id) init {
    self = [super init];
    if (self != nil) {
        
		NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"settings.plist"];
		//CCLOG(@"Path: %@",plistPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
        }
		//CCLOG(@"Path: %@",plistPath);
		
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
											  propertyListFromData:plistXML
											  mutabilityOption:NSPropertyListMutableContainersAndLeaves
											  format:&format
											  errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
		
		instruments = [[NSMutableArray alloc] initWithArray:[temp objectForKey:@"instruments"]];
        menuItems = [[NSMutableArray alloc] initWithCapacity:[instruments count]];
		selectedMenuItems = [[NSMutableArray alloc] initWithCapacity:[instruments count]];
		
        menu =[CCSprite spriteWithFile:@"menuBackground.png"];
		int r =0;
        int c = 0;
        menuWidth = [instruments count] * (THUMBW+PADW)-PADW;
        for (int i=0; i< [instruments count]; i++) {
            
            CCSprite *item = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@Menu.png",[instruments objectAtIndex:i]]];
            [menuItems insertObject:item atIndex:i];
            
            CCSprite *selectedItem = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@MenuSelected.png",[instruments objectAtIndex:i]]];
            [selectedItem setVisible:NO];
            [selectedMenuItems insertObject:selectedItem atIndex:i];
            
            if (IS_IPAD()) {
                HALF_DROP_SHADOW_W = 7*IPAD_MULT;
            } else {
                HALF_DROP_SHADOW_W = 7;
            }
            if ((i%2) == 0) {
                [item setPosition:ccp(SCREEN_CENTER_X+(i/2)*(THUMBW+PADW)+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
                [selectedItem setPosition:ccp(SCREEN_CENTER_X+(i/2)*(THUMBW+PADW)+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
            } else {
                if (i==1) {
                    [item setPosition:ccp(SCREEN_CENTER_X-(i)*(THUMBW+PADW)+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
                    [selectedItem setPosition:ccp((SCREEN_CENTER_X-(i)*(THUMBW+PADW))+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
                } else {
                    [item setPosition:ccp(SCREEN_CENTER_X-(i-1)*(THUMBW+PADW)+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
                    [selectedItem setPosition:ccp(SCREEN_CENTER_X-(i-1)*(THUMBW+PADW)+HALF_DROP_SHADOW_W, SCREEN_CENTER_Y)];
                }
            }
            [menu addChild:item z:30];
            [menu addChild:selectedItem z:31];
            item.tag = i;
            if (r==2) {
                c++;
            }
            r=(r+1)%3;
        }
        
		[menu setAnchorPoint:ccp(0,0)];
		//[menu setPosition:ccp(0, 0)];
        //CCLOG(@"current_item: %2i",current_item);
        if ((current_item % 2) == 0) {
            [menu setPosition:ccp(SCREEN_CENTER_X-(current_item/2)*(THUMBW+PADW) - SCREEN_CENTER_X, 0)];
        } else {
            if (current_item==1) {
                [menu setPosition:ccp(SCREEN_CENTER_X+(current_item)*(THUMBW+PADW) - SCREEN_CENTER_X, 0)];
            } else {
                [menu setPosition:ccp(SCREEN_CENTER_X+(current_item-1)*(THUMBW+PADW) - SCREEN_CENTER_X, 0)];
            }
        }
        
        [self addChild:menu z:10];
	        
        self.isTouchEnabled = YES;
        screenIsTouched = FALSE;
        endLocation = ccp(menu.position.x, menu.position.y);
        startTouch = ccp(menu.position.x, menu.position.y);
        [self schedule: @selector(tick:) interval: 0.25f ];
        waitForMoveTo=NO;
        startedMoveTo=NO;
        selected=-1;
    }

    return self;
}

-(void) tick: (ccTime) dt {
    if (!startedMoveTo) {
        waitForMoveTo = NO;
    }
    if (startedMoveTo) {
        startedMoveTo = NO;
    }
}

-(void)startInstrument: (id) sender {
    // Note: no longer used
	CCMenuItem *item = (CCMenuItem *)sender;
	InstrumentScene *instrumentScene = [InstrumentScene node];
	instrumentScene.instrument_name = [instruments objectAtIndex:item.tag];
    current_item = (int)item.tag;
    //CCLOG(@"Start: current_item: %2i",current_item);
	[instrumentScene loadInstrument];
    [[CCDirector sharedDirector] replaceScene:instrumentScene];
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ((!screenIsTouched)&&(!waitForMoveTo)) {
		screenIsTouched = TRUE;
		CGPoint location;
		UITouch *touch = [touches anyObject];
		location = [touch locationInView: [touch view]];
		location  = [[CCDirector sharedDirector] convertToGL:location ];
        for (int i=0; i<[menuItems count]; i++) {
            CCSprite *s = [menuItems objectAtIndex:i];
            CGPoint sLocation = s.position;
            sLocation.x = sLocation.x+menu.position.x;
            if (((sLocation.x-THUMBW/2)<location.x) && ((sLocation.x+THUMBW/2)>location.x) &&
                ((sLocation.y-THUMBH/2)<location.y) && ((sLocation.y+THUMBH/2)>location.y)) {
                [[selectedMenuItems objectAtIndex:i ] setVisible:YES];
                selected = i;
            }
        }
        xAtFirstTouch= location.x; 
        xAtLastMove = location.x;
        origX = menu.position.x;
        deltaX = 0;
        incX = 0;
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ((screenIsTouched)&&(!waitForMoveTo)) {
        if (selected >=0) {
            [[selectedMenuItems objectAtIndex:selected ] setVisible:NO];
            selected = -1;
        }
		CGPoint location;
		UITouch *touch = [touches anyObject];
		location = [touch locationInView: [touch view]];
		location  = [[CCDirector sharedDirector] convertToGL:location ];
		endLocation = location;
	    incX = location.x-xAtLastMove;
        deltaX = location.x-xAtFirstTouch;
        [menu setPosition:ccp(menu.position.x+incX, menu.position.y)];
        xAtLastMove = location.x; 
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (selected >=0) {
        InstrumentScene *instrumentScene = [InstrumentScene node];
        instrumentScene.instrument_name = [instruments objectAtIndex:selected];
        current_item = selected;
        [instrumentScene loadInstrument];
        [[CCDirector sharedDirector] replaceScene:instrumentScene];
    } else {
        if ((screenIsTouched)&&(!waitForMoveTo)) {
            
            screenIsTouched = FALSE;
            startedMoveTo = YES;
            waitForMoveTo = YES;
  
            if (((deltaX)>50) && ((origX+THUMBW+PADW)<menuWidth-THUMBW-PADW)) {
                [menu runAction: [CCMoveTo actionWithDuration:.25 position:ccp(origX+THUMBW+PADW, menu.position.y)]];
            } else {
                if (((deltaX)<-50) && ((origX-THUMBW-PADW)>-menuWidth+THUMBW+PADW)) {
                    [menu runAction: [CCMoveTo actionWithDuration:.25 position:ccp(origX-THUMBW-PADW, menu.position.y)]];
                } else {
                    [menu runAction: [CCMoveTo actionWithDuration:.25 position:ccp(origX, menu.position.y)]];
                }
            }
        }
    }
}

-(void) dealloc
{ 
    //CCLOG(@"Releasing MenuLayer");
	[instruments release];
    [menuItems release];
    [selectedMenuItems release];
	[super dealloc];
}

@end
