//
//  OscillatorInstrument.swift
//  OF-AK-HelloWorld
//
//  Created by Nicholas Arner on 4/12/16.
//
//

import Foundation
import AudioKit

public class OscillatorInstrument: NSObject {
    var oscillator = AKOscillator()
    
    public override init() {
        AudioKit.output = oscillator
        AudioKit.start()
    }
    
    public func startSound() {
        oscillator.start()
    }
    
    public func stopSound(){
        oscillator.stop()
    }
    
}

    