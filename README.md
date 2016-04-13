# OpenFrameworks-and-AudioKit

### Introduction

If you're making an OpenFrameworks project that will only run on an OS X device, it's possible to include [AudioKit](http://audiokit.io/)
in your OpenFrameworks project. AudioKit gives you the ability to quickly prototype great sounding instruments, and is written in pure 
Swift. If you're an OpenFrameworks developer who's not familiar with AudioKit, check out some of the work shown in our 
[gallery](http://audiokit.io/gallery/). Hopefully they will inspire you to use AudioKit in some of your games or installations! This 
tutorial will show you how to add AudioKit to your OpenFrameworks project, and create a simple Hello World example. While it's a rather 
simple sounding oscillator, it's important to remember that anything you hear in the Gallery pages that you like can also be implemented
in your Open Frameworks project. 


### Getting Started

Before we start, make sure that you have: 

1) Xcode 7.3 installed 

2) OpenFrameworks 0.9.3 installed

3) You have a [copy of AudioKit](https://github.com/audiokit/AudioKit). Make sure that you're using AudioKit 3.1.1 and later (photo)

We can go ahead and create our OpenFrameworks project now. Using the Project Generator (...make sure to put exact title, and show that 
we're putting this in "my apps") (photo). 

Since AudioKit is a Swift library, there's a few things we'll need to consider. First, any file that we want to call AudioKit code from
will need to be an Objective-C++ file. This is because while it's possible to call Swift code from Objective-C++ code, it is not possible
to do so from C++. To change the file type, change the file extension from `.cpp` to `.mm`. We're going to do this for both our
`ofApp.cpp` and our `main.cpp` files (photo). After you've done this, change the source type to "Objective-C++" source on the right hand 
side: (photo). 

Again, it's important to remember that because we're changing the file types, your OpenFrameworks project will only compile on an OS X
device. 

To add AudioKit to your project, navigate to the `AudioKit OSX.xcodeproj` inside your AudioKit folder (photo), and drag it into your 
OpenFrameworks Xcode project (photo). AudioKit 3.1.0 and later rquires OS X 10.11. Make sure that 10.11 is set as your Deployment Target 
(under the "General) tab (photo).

Now, we're going to add in the path to the AudioKit framework. Go to Build Settings in Xcode, and search for "Framework Search Paths" 
(photo.....)

Now, we're going to create a Swift file to define our AudioKit instrument in. We're going to call our file `OscillatorInstrument.swift`. 
Xcode will ask you if you want to create a Bridging Header (photo). We don't need one, as we're calling Swift code from Objective-C++, 
and not the other way around.

Now, build your project. This will auto-generate a `Swift.h` file, which is what allows us to call into Swift code from Objective-C++.
You can find this file by going to ...(photo). Our file name should be (double check!)

Go to your `ofApp.mm` file and add the import statement below:
`import mySwift.h` file here

Build your project again to make sure that you've sucesfully imported this file. If you get an error, you probably forgot to build after
you created your `OscillatorInstrument.swift` file. 

If you imported `mySwift.h` succesfully, then you're ready to create your oscillator! Go to `OscillatorInstrument.swift`, and import 
AudioKit by adding the line below under `import Foundation`:
`import AudioKit`

If you've done everything correctly so far, your project should build successfully. If not, 
