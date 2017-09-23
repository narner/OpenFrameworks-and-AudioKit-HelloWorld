//
//  AKOfflineRenderAudioUnit.h
//  AudioKit For iOS
//
//  Created by David O'Neill on 8/7/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//

#pragma once
#import "AKAudioUnit.h"

@interface AKOfflineRenderAudioUnit : AKAudioUnit
@property BOOL internalRenderEnabled; // default = true;

-(AVAudioPCMBuffer * _Nullable)renderToBuffer:(NSTimeInterval)seconds error:(NSError *_Nullable*__null_unspecified)outError;

-(BOOL)renderToFile:(NSURL * _Nonnull)fileURL seconds:(double)seconds settings:(NSDictionary<NSString *, id> * _Nullable)settings error:(NSError * _Nullable * _Nullable)error;

@end
