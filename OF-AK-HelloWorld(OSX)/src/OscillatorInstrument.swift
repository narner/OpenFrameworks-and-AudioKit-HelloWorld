//
//  OscillatorInstrument.swift
//  OF-AK-HelloWorld
//
//  Created by Nicholas Arner on 4/12/16.
//
//

import Foundation
import AudioKit

open class OscillatorInstrument: NSObject {
    var oscillator = AKOscillator()
    
    public override init() {
        AudioKit.output = oscillator
        AudioKit.start()
    }
    
    open func startSound() {
        oscillator.start()
    }
    
    open func stopSound(){
        oscillator.stop()
    }
    
}

    
