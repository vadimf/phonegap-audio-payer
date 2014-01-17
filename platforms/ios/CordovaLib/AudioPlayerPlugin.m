//
//  GBBackgroundAudioPlayer.m
//  audioplayer
//
//  Created by Vadim Fainshtein on 1/16/14.
//  Copyright (c) 2014 GlobalBit. All rights reserved.
//

#import "GBBackgroundAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation GBBackgroundAudioPlayer


- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    
    //get the callback id
    NSString *callbackId = [arguments pop];
    
    NSLog(@"Hello, this i s a native function called from PhoneGap/Cordova!");
    
    
    NSString *resultType = [arguments objectAtIndex:0];
    CDVPluginResult *result;
    
    if ( [resultType isEqualToString:@"success"] ) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

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
    
    //   [self play];
}

-(void)addNextURL:(NSString*)urlString{
    NSLog(@"url:%@",urlString);
    
    NSURL *url=[NSURL URLWithString:urlString];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    NSArray *keys = [NSArray arrayWithObject:@"playable"];
    
//    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^()
//     {
//         dispatch_async(dispatch_get_main_queue(), ^
//                        {
//                            AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
//                            [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
//                            [player insertItem:playerItem afterItem:nil];
//                        });
//         
//     }];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
    [player insertItem:playerItem afterItem:nil];
}

-(void)playFromURL:(NSString*)urlString{
  
    NSLog(@"url:%@",urlString);
    

    [player removeAllItems];
    [self addNextURL:urlString];
    [player play];
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
            // [player play];
            NSLog(@"player status:%d",player.status);
            
        } else if (player.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else  if ([object isKindOfClass:[AVPlayerItem class]] && [keyPath isEqualToString:@"status"]) {
        if (player.status == AVPlayerStatusReadyToPlay) {
            // [player play];
            NSLog(@"playeritem status:%d",player.status);
            
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
