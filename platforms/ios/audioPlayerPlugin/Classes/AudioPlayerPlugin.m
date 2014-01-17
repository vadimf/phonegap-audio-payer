//
//  AudioPlayerPlugin.m
//  audioPlayerPlugin
//
//  Created by Vadim Fainshtein on 1/16/14.
//
//

#import "AudioPlayerPlugin.h"

@implementation AudioPlayerPlugin


-(void)playNext:(CDVInvokedUrlCommand*)command{
    NSLog(@"playNext");
    if (!audioPlayer){
        audioPlayer = [[GBAudioPlayer alloc]init];
        audioPlayer.delegate = self;
    }
    [audioPlayer playNext];
}
-(void)playURL:(CDVInvokedUrlCommand*)command{
    NSLog(@"playURL");

    if (!audioPlayer){
        audioPlayer = [[GBAudioPlayer alloc]init];
                audioPlayer.delegate = self;
    }
    NSString* urlString;
    NSString* songTitle;
    NSString* artist;
    NSString* albumTitle;
    
    if ([command.arguments objectAtIndex:0]){
        urlString =[command.arguments objectAtIndex:0];
    }
    else{
        return;
    }
    if ([command.arguments objectAtIndex:1]){
        songTitle =[command.arguments objectAtIndex:1];
    }
    if ([command.arguments objectAtIndex:2]){
        albumTitle =[command.arguments objectAtIndex:2];
    }
    if ([command.arguments objectAtIndex:3]){
        artist =[command.arguments objectAtIndex:3];
    }

    [audioPlayer playURL:urlString withSongTitle:songTitle andAlbumTitle:albumTitle andArtistName:artist];
    
}

-(void)pause:(CDVInvokedUrlCommand*)command{
    NSLog(@"pause");

    if (!audioPlayer){
        audioPlayer = [[GBAudioPlayer alloc]init];
                audioPlayer.delegate = self;
    }
     [audioPlayer pause];
}

-(void)addNextURL:(CDVInvokedUrlCommand*)command{
    NSLog(@"addNextURL");

    if (!audioPlayer){
        audioPlayer = [[GBAudioPlayer alloc]init];
                audioPlayer.delegate = self;
    }
    NSString* urlString = [command.arguments objectAtIndex:0];
    [audioPlayer addNextURLWithString:urlString];
}

-(void)play:(CDVInvokedUrlCommand*)command{
    NSLog(@"play");

    if (!audioPlayer){
        audioPlayer = [[GBAudioPlayer alloc]init];
        audioPlayer.delegate = self;
    }
     [audioPlayer play];
    
}

-(void)didFinishPlayingSong{
    NSLog(@"didFinishPlayingSong");

     [self.webView stringByEvaluatingJavaScriptFromString:@"ended()"];
}

@end
