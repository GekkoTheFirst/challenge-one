# Structure
It is my solution for the test challenge. It is written in ruby & in java.
Ruby solution is located [HERE](https://github.com/GekkoTheFirst/challenge-one/tree/master/ruby)
*WIP* Java solution is located [HERE](https://github.com/GekkoTheFirst/challenge-one/tree/master/ruby)

This article contains few chapters to explain the steps how to build & run the project on an Android simulator.

## Application
This is how application looks like:
![GitHub](/resources/app.png)


### Pre-work & emulator
To start this project I had to perform some background job first. I started with creating an apk file in Android studio.
The apk file can be located [here](https://github.com/GekkoTheFirst/challenge-one/tree/master/resources).
To make an apk file you would need to use next tools: Android studio, AVD manager and adb (android  debug bridge). You can get all these tools by downloading & installing [Android studio](https://developer.android.com/studio).

After installing the tools, you would need to create at least one emulator in AVD manager. You can find [how to article here](https://developer.android.com/studio/run/managing-avds) (don't forget to download all components via avd manager).

### GitHub
Clone the repository on your machine.

### Java, Ruby & bundle
If you run JAVA solution, you need to install [Java](https://www.java.com/en/download/). You need to install before running the project.

*WIP*

If you run ruby solution, you need ruby if you do not have it yet. Also I use [bundler](https://bundler.io/) to keep gems dependencies. It means bundler need to be installed first by next command inside cloned directory:
> $ gem install bundler

Next step is to install all dependencies (gems)
> $ bundle install

Do not forget to install java as it is required by Appium and Android studio.

### Appium
Appium web driver can be downloaded in two ways: [via terminal](http://appium.io/docs/en/about-appium/getting-started/) or download [a client](https://github.com/appium/appium-desktop/releases/tag/v1.15.1). I personally prefer a terminal command.

If you face with some problems, install a npm package: *[appium-doctor](https://www.npmjs.com/package/appium-doctor)*. It helps you to locate a problematic point on your machine because Appium requires a lot of dependencies and correct paths.

_Android setup_
Appium will use the first device that connected to ADB so please check adb devices and make sure that at lease one device is connected.
*NB!* Do not forget to activate [USB debugging](https://www.qafox.com/appium-enabling-debugging-mode-in-android-devices-emulators/) on emulator otherwise Appium won't recognise your device.

If you look for more information, you find it [here](https://github.com/appium/appium/blob/master/docs/en/drivers/android-uiautomator2.md)

### License
appium & RxJava use Apache License 2.0
https://github.com/appium/appium/blob/master/LICENSE
https://github.com/ReactiveX/RxJava/blob/3.x/LICENSE
