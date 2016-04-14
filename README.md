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

1) [Xcode 7.3](https://developer.apple.com/xcode/download/) installed 

2) [OpenFrameworks 0.9.3](http://openframeworks.cc/download/) downloaded

3) You've downloaded the source code of [AudioKit](https://github.com/audiokit/AudioKit), and
that your branch is pointed to 3.1.1 or later.

We can go ahead and create our OpenFrameworks project now. Using the Project Generator, go ahead and 
create a new OS X project. Call it "OF-AK-HelloWorld", and set it's location to be inside of the 
"My Apps" folder:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/myApps.png)

Since AudioKit is a Swift library, there's a few things we'll need to consider. First, any file that
we want to call AudioKit code from will need to be an Objective-C++ file. This is because while it's 
possible to call Swift code from Objective-C++ code, it is not possible to do so from C++. To change 
the file type, change the file extension from `.cpp` to `.mm`. We're going to do this for our
`ofApp.cpp` and our `main.cpp` files. After you've done this, change the file type to 
"Objective-C++" source. 

Your file information will look like this at first:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/cpp.png)

...and should look like this once you've changed it's information:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/mm.png)

Again, it's important to remember that because we're changing the file types, your OpenFrameworks 
project will only compile on an OS X device. 

Because AudioKit 3.1.1 requires Swift 3, our app's Deployment Target needs to be OS X 10.11. Go to 
your project's "General" tab 

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/generalTab.png)

and make sure that the Deployment Target is set to 10.11.

### Adding AudioKit

Now, we can add AudioKit to our project. Navigate to the `AudioKit OSX.xcodeproj` inside your 
AudioKit folder (photo), 

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/akProject.png)

and drag it into your OpenFrameworks Xcode project (photo). 

Now, we're going to add in the path to the AudioKit OS X Framework. Go to Build Settings in Xcode, 
and search for "Framework Search Paths":

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/frameworkSearchPaths.png)

And enter the path to your AudioKit-OSX framework:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/frameworkPath.png)

Your path will look different based on where your AudioKit code is on your machine.

Now, we're going to create a Swift file to define our AudioKit instrument in. We're going to call our file `OscillatorInstrument.swift`. 

Xcode will ask you if you want to create a Bridging Header...we don't need one, as we're calling 
Swift code from Objective-C++, and not the other way around.

Now, build your project. This will auto-generate a `Swift.h` file, which is what allows us to call 
into Swift code from Objective-C++. You can find this file by going to Build Settings, and searching
for "Interface Header". You should see a listing for an "Objective-C Generated Interface Header 
Name", and it should be named `OF_AK_HelloWorldDebug-Swift.h`:

![Alt Text](https://github.com/narner/OpenFrameworks-and-AudioKit-HelloWorld/raw/master/tutorialImages/interfaceHeader.png)

Go to your `ofApp.h` file and add the import statement below:
`#import "OF_AK_HelloWorldDebug-Swift.h`

Build your project again to make sure that you've sucesfully imported this file. If you get an 
error, you probably forgot to build after you created your `OscillatorInstrument.swift` file. 

If you imported `mySwift.h` succesfully, then you're ready to create your oscillator! Go to `
OscillatorInstrument.swift`, and import AudioKit by adding the line below under `import Foundation`:
`import AudioKit`

Add the code below to create a simple oscillator instrument, as well as functions for turning it
on and off:

```
@objc public class OscillatorInstrument: NSObject {
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
```

### Creating and Interacting with our Oscillator 

Now, go to your `ofApp.mm` file, and add the line below as a global variable:

`OscillatorInstrument *instrument = [[OscillatorInstrument alloc] init];`

This will create an instance of our `OscillatorInstrument` class called "Instrument" as soon as our 
app has started. 

Now, we want to give our app the ability to start and stop our oscillator. To do that, we'll add a 
call to our "Stop" method inside of the `mousePressed` event method:

```
void ofApp::mousePressed(int x, int y, int button){
    [instrument startSound];

}
```

And, to stop our oscillator, add a call to our "Stop" method inside of the `mouseReleased method`:

```
//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
    [instrument stopSound];
}
```

Go ahead and run the app. When it starts, press down on your mouse. You should hear an oscillator!
To stop the sound, just let go of your mouse. 