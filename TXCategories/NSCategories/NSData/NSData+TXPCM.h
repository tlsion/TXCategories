//
//  NSData+TXPCM.h
//  TXCategories (https://github.com/tlsion/TXCategories)
//
//  Created by 王-庭协 on 2017/1/12.
//  Copyright © 2017年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
/*
 
AudioStreamBasicDescription _format;
_format.mFormatID = kAudioFormatLinearPCM;
_format.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
_format.mBitsPerChannel = 16;
_format.mChannelsPerFrame = 1;
_format.mBytesPerPacket = _format.mBytesPerFrame = (_format.mBitsPerChannel / 8) * _format.mChannelsPerFrame;
_format.mFramesPerPacket = 1;
_format.mSampleRate = 8000.0f;
*/

@interface NSData (TXPCM)
/**
 *  format wav data
 *
 *  @param self   raw audio data
 *  @param pcmFormat format of pcm
 *
 *  @return wav data
 */
- (NSData *)tx_wavDataWithPCMFormat:(AudioStreamBasicDescription)PCMFormat;
@end
