# Structure
It is a solution for the test challenge. It is written in ruby, because of the time limit - one day.
However it can be easily converted into Java syntax. All relevant and required information for this application
can be found on [appium website](http://appium.io/docs/en/commands/status/).

![GitHub](/resources/app.png)

This article contains few chapters to explain the steps to run the project on Android simulator.

### Pre-work & emulator
To start this project I had to perform some background work first. I started with creating an apk file in Android studio.
The apk file can be located [here](https://github.com/GekkoTheFirst/challenge-one/tree/master/resources).
To make an apk file please download [Android studio](https://developer.android.com/studio), AVD manager and adb (android  debug bridge).

In AVD manager you need to create [an emulator](https://developer.android.com/studio/run/managing-avds) (don't forget to download all components).

### GitHub
Clone the repository on your machine.

### Ruby & bundle
You need to install ruby if you do not have it yet. Also I use [bundler](https://bundler.io/) to keep gems dependencies. It means bundler need to be installed first by next command inside cloned directory:
> $ gem install bundler

Next step is to install all dependencies (gems)
> $ bundle install

We are almost on half way to success.

### Appium
Appium web driver can be downloaded in two ways: [via terminal](http://appium.io/docs/en/about-appium/getting-started/) or download [a client](https://github.com/appium/appium-desktop/releases/tag/v1.15.1).

I prefer a terminal command. Do not forget to use *appium-doctor*. It helps you to locate a problematic point on your machine as Appium requires a lot of dependencies and correct paths.

### Run project
If you read this section I assume you performed all required actions.
* By now you should have android emulator that can be launched by:
> $ emulator -avd avd_name

If you do not know the name of you emulator use this command to find existing emulators:
> $ emulator -list-avds

*NB!* Do not forget to activate [debugging mode](https://www.qafox.com/appium-enabling-debugging-mode-in-android-devices-emulators/) on emulator otherwise Appium won't recognise your device.

* Open new terminal window and start Appium client by:
> appium

* Opne another terminal window and navigate to project folder. We can run the project by next command:
> $ rspec main_activity_spec.rb

I use rspec testing framework to generate a report in the terminal (that's why you need 3 terminal windows at the same time).

There are 14 testing cases where 2 cases failing. It means the app has defects. Screenshots are made after the run. It can be located in _/outputs_ folder.

### License
Appium uses [Apache License 2.0](https://github.com/appium/appium/blob/master/LICENSE)
