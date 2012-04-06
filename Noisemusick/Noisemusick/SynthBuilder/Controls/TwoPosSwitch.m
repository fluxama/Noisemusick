/*
 *  TwoPosSwitch.m
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "TwoPosSwitch.h"

@implementation TwoPosSwitch

-(id) initWithDictionary: (NSDictionary *) params {
	if( (self=[super initWithDictionary: params] )) {
		sprite = [CCSprite spriteWithFile:@"twoPosSwitch0.png"];
		sprite.position = ccp(0, 0);
		sprite.visible = YES;
		[self addChild:sprite];
		sprite_highlight = [CCSprite spriteWithFile:@"twoPosSwitch1.png"];
		sprite_highlight.position = ccp(0, 0);
		sprite_highlight.visible = NO;
		[self addChild:sprite_highlight];
	}
	return self;
}

-(void) touchRemoved:(UITouch *) touch {
	if (control_state == 0) {
		control_state = 1;
		control_value = 1;
        sprite.visible = NO;
        sprite_highlight.visible = YES;
	} else {
		control_state = 0;
		control_value = 0;
        sprite.visible = YES;
        sprite_highlight.visible = NO;
	}
    [self sendControlValues];
}

@end
