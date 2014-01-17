//
//  GBBackgroundAudioPlayer.m
//  audioplayer
//
//  Created by Vadim Fainshtein on 1/16/14.
//  Copyright (c) 2014 GlobalBit. All rights reserved.
//

#import "GBAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation GBAudioPlayer


- (id) init{
	self = [super init];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
 
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
    AudioSessionSetActive(true);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    player = [[AVQueuePlayer alloc]init];
    player.actionAtItemEnd = AVPlayerActionAtItemEndAdvance;
    
    player.volume = 1.0f;
    [player addObserver:self forKeyPath:@"status" options:0 context:nil];
    
	return self;
}

-(void)didFinish{
    NSLog(@"did finish");
    [_delegate didFinishPlayingSong];
    //   [self play];
}

-(void)addNextURLWithString:(NSString*)urlString{
    NSLog(@"url:%@",urlString);
    
    NSURL *url=[NSURL URLWithString:urlString];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];

    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
    [player insertItem:playerItem afterItem:nil];
}

-(void)playURL:(NSString*) urlString withSongTitle:(NSString*)songTitle andAlbumTitle:(NSString*)albumTitle andArtistName:(NSString*)artistName{
    NSLog(@"url:%@",urlString);
    
    MPMediaItemArtwork* artwork = 	[[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:@"IMG_2414.jpg"]];
    NSDictionary *nowPlaying = @{MPMediaItemPropertyTitle: songTitle,
                                 MPMediaItemPropertyArtist: artistName,
                                 MPMediaItemPropertyAlbumTitle: albumTitle,
                                 MPMediaItemPropertyArtwork: artwork};
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nowPlaying];
    
    [player removeAllItems];
    [self addNextURLWithString:urlString];
    [self play];
}

-(void)play{
    
    [player play];

    
}

-(void)playNext{
    [player advanceToNextItem];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"observer player:%d",player.status);
    NSLog(@"observer playeritem:%d",player.currentItem.status);
    
    if (object == player && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"player status:%d",player.status);
            
        } else if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else  if ([object isKindOfClass:[AVPlayerItem class]] && [keyPath isEqualToString:@"status"]) {
        if (player.currentItem.status == AVPlayerStatusReadyToPlay) {
            // [player play];
            NSLog(@"playeritem status:%d",player.currentItem.status);
            
        } else if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    }
}

-(void)pause{
    [player pause];
}





- (NSString *)OSStatusToStr:(OSStatus)st
{
    switch (st) {
        case kAudioFileUnspecifiedError:
            return @"kAudioFileUnspecifiedError";
            
        case kAudioFileUnsupportedFileTypeError:
            return @"kAudioFileUnsupportedFileTypeError";
            
        case kAudioFileUnsupportedDataFormatError:
            return @"kAudioFileUnsupportedDataFormatError";
            
        case kAudioFileUnsupportedPropertyError:
            return @"kAudioFileUnsupportedPropertyError";
            
        case kAudioFileBadPropertySizeError:
            return @"kAudioFileBadPropertySizeError";
            
        case kAudioFilePermissionsError:
            return @"kAudioFilePermissionsError";
            
        case kAudioFileNotOptimizedError:
            return @"kAudioFileNotOptimizedError";
            
        case kAudioFileInvalidChunkError:
            return @"kAudioFileInvalidChunkError";
            
        case kAudioFileDoesNotAllow64BitDataSizeError:
            return @"kAudioFileDoesNotAllow64BitDataSizeError";
            
        case kAudioFileInvalidPacketOffsetError:
            return @"kAudioFileInvalidPacketOffsetError";
            
        case kAudioFileInvalidFileError:
            return @"kAudioFileInvalidFileError";
            
        case kAudioFileOperationNotSupportedError:
            return @"kAudioFileOperationNotSupportedError";
            
        case kAudioFileNotOpenError:
            return @"kAudioFileNotOpenError";
            
        case kAudioFileEndOfFileError:
            return @"kAudioFileEndOfFileError";
            
        case kAudioFilePositionError:
            return @"kAudioFilePositionError";
            
        case kAudioFileFileNotFoundError:
            return @"kAudioFileFileNotFoundError";
            
        default:
            return @"unknown error";
    }
}

@end
