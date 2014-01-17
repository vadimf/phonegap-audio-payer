//
//  GBBackgroundAudioPlayer.h
//  audioplayer
//
//  Created by Vadim Fainshtein on 1/16/14.
//  Copyright (c) 2014 GlobalBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDVPlugin.h"

@class AVQueuePlayer;

@interface GBBackgroundAudioPlayer : CDVPlugin {
    NSString* callbackID;

    AVQueuePlayer   *player;
}


-(void)playNext;
-(void)playURL:(NSString*)play;
-(void)pause;
-(void)addNextURL:(NSString*)urlString;
-(void)play;


- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;


@property (nonatomic, copy) NSString* callbackID;

@end
