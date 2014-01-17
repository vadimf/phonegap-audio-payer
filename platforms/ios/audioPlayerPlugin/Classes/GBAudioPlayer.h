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


@protocol GBAudioPlayerDelegate <NSObject>

-(void)didFinishPlayingSong;

@end

@interface GBAudioPlayer : NSObject  {

    AVQueuePlayer   *player;
}


-(void)playNext;
-(void)playURL:(NSString*) urlString withSongTitle:(NSString*)songTitle andAlbumTitle:(NSString*)albumTitle andArtistName:(NSString*) artistName;
-(void)pause;
-(void)addNextURLWithString:(NSString*)urlString;

-(void)play;

@property (nonatomic, assign) id<GBAudioPlayerDelegate> delegate;

@end
