//
//  main.m
//  CAMetadata
//
//  Created by Tony Hillerson on 7/8/12.
//  Copyright (c) 2012 Tack Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        if (argc < 2) {
            printf("Usage: CAMetadata /full/path/to/audiofile/n");
            return -1;
        }
        
        NSString *audioFilePath = [[NSString stringWithUTF8String:argv[1]] stringByExpandingTildeInPath];
        NSURL *audioURL = [NSURL fileURLWithPath:audioFilePath];
        AudioFileID audioFile = nil;
        OSStatus err = noErr;
        err = AudioFileOpenURL((CFURLRef)audioURL, kAudioFileReadPermission, 0, &audioFile);
        assert(err == noErr);
        UInt32 dictionarySize = 0;
        err = AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, 0);
        assert(err == noErr);
        CFDictionaryRef dictionary;
        err = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary);
        assert(err == noErr);
        NSLog(@"info: %@", dictionary);
        CFRelease(dictionary);
        err = AudioFileClose(audioFile);
        assert(err == noErr);
    }
    return 0;
}

