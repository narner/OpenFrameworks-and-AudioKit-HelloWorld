# OpenFrameworks-and-AudioKit

### Introduction

If you're making an OpenFrameworks project that will only run on an OS X device, it's possible to 
include [AudioKit](http://audiokit.io/) in your OpenFrameworks project. AudioKit gives you the 
ability to quickly prototype great sounding instruments, and is written in pure 
Swift. If you're an OpenFrameworks developer who's not familiar with AudioKit, check out some of 
the work shown in our [gallery](http://audiokit.io/gallery/). Hopefully they will inspire you to 
use AudioKit in some of your games or installations! This tutorial will show you how to add 
AudioKit to your OpenFrameworks project, and create a simple Hello World example. While it's a 
rather simple sounding oscillator, it's important to remember that anything you hear in the Gallery 
pages that you like can also be implemented in your Open Frameworks project. 

### Getting Started

Before we start, make sure that you have: 

1) [Xcode 8.2.1 or higher](https://developer.apple.com/xcode/download/) installed 

2) [OpenFrameworks 0.9.4](http://openframeworks.cc/download/) or later downloaded for OS X

3) You've downloaded the [AudioKit-OSX-3.5.zip](https://github.com/audiokit/AudioKit/releases/tag/v3.5).

We can create our OpenFrameworks project now. Using the Project Generator, go ahead 
and create a new OS X project. Call it "OF-AK-HelloWorld", and set its location to be inside of 
the default "My Apps" folder:

Since AudioKit is a Swift framework, there's a few things we'll need to consider. First, any file 
that we want to call AudioKit code from will need to be an Objective-C++ file. This is because 
while it's possible to call Swift code from Objective-C++ code, it is not possible to do so from 
C++. To change the file type, change the file extension from `.cpp` to `.mm`. We're going to do 
this for our`ofApp.cpp` and our `main.cpp` files. After you've done this, change the file type to 
"Objective-C++" source. 

Your file information will look like this at first:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/cpp.png)

...and should look like this once you've changed it's information:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/mm.png)

Again, it's important to remember that because we're changing the file types, your OpenFrameworks 
project will only compile on an OS X device. 

Because AudioKit 3.5 and above requires Swift 3.2, our app's Deployment Target needs to be OS X 
10.11 or higher. Go to your project's "General" tab 

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/generalTab.png)

and make sure that the Deployment Target is set to 10.11.

### Adding AudioKit

AudioKit comes with pre-compiled frameworks. If you're planning on distributing your app, we 
recommend copying the framework into your project:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/copiedFramework.png)

Make sure that the framework is included in your app's Embedded Binaries listing:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/embeddedBinaries.png)

Now, we're going to create a Swift file to define our AudioKit instrument in. We're going to call 
our file `OscillatorInstrument.swift`. 

Xcode will ask you if you want to create a Bridging Header...we don't need one, as we're calling 
Swift code from Objective-C++, and not the other way around.

Now, build your project. This will auto-generate a `Swift.h` file, which is what allows us to 
call into Swift code from Objective-C++. You can find this file by going to Build Settings, and 
searching for "Interface Header". You should see a listing for an "Objective-C Generated 
Interface Header Name", and it should be named `OF_AK_HelloWorldDebug-Swift.h`:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/interfaceHeader.png)

Go to your `ofApp.h` file and add the import statement below:
`#import "OF_AK_HelloWorldDebug-Swift.h`

NOTE: Occasionally, this may not display the full-text of the `Swift.h` file, and may display as
`$(SWIFT_MODULE_NAME)-Swift.h`. This appears to be a bug in Xcode.

Build your project again to make sure that you've sucesfully imported this file. If you get an 
error, you probably forgot to build after you created your `OscillatorInstrument.swift` file. 

Go to `OscillatorInstrument.swift`, and import AudioKit by adding the line below under 
`import Foundation`:
`import AudioKit`

Add the code below to create a simple oscillator instrument, as well as functions for turning it
on and off:

```swift
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
```

### Creating and Interacting with our Oscillator 

Now, go to your `ofApp.mm` file, and add the line below as a global variable:

```Objective-C
#include "ofApp.h"

OscillatorInstrument *instrument = [[OscillatorInstrument alloc] init];

//--------------------------------------------------------------
void ofApp::setup(){
}
```

This will create an instance of our `OscillatorInstrument` class called "Instrument" as soon as 
our app has started. 

Now, we want to give our app the ability to start and stop our oscillator. To do that, we'll add a 
call to our "Stop" method inside of the `mousePressed` event method:

```C++
void ofApp::mousePressed(int x, int y, int button){
    [instrument startSound];
}
```

And, to stop our oscillator, add a call to our "Stop" method inside of the `mouseReleased method`:

```C++
void ofApp::mouseReleased(int x, int y, int button){
    [instrument stopSound];
}
```

Go ahead and run the app. When it starts, press down on your mouse. You should hear an oscillator!
To stop the sound, just let go of your mouse. 
