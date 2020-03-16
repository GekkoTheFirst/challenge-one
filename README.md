# Structure
It is my solution for the test challenge. It is written in ruby. However it can be easily converted into Java syntax. All relevant and required information for this application can be found on [appium website](http://appium.io/docs/en/commands/status/).

This article contains few chapters to explain the steps how to build & run the project on an Android simulator.

## Application
![GitHub](/resources/app.png)


### Pre-work & emulator
To start this project I had to perform some background job first. I started with creating an apk file in Android studio.
The apk file can be located [here](https://github.com/GekkoTheFirst/challenge-one/tree/master/resources).
To make an apk file you would need to use next tools: Android studion, AVD manager and adb (android  debug bridge). You can get all these tools by downloading & installing [Android studio](https://developer.android.com/studio).

After installing the tools, you would need to create at least one emulator in AVD manager. You can find [how to article here](https://developer.android.com/studio/run/managing-avds) (don't forget to download all components via avd manager).

### GitHub
Clone the repository on your machine.

### Java, Ruby & bundle
You need to install ruby if you do not have it yet. Also I use [bundler](https://bundler.io/) to keep gems dependencies. It means bundler need to be installed first by next command inside cloned directory:
> $ gem install bundler

Next step is to install all dependencies (gems)
> $ bundle install

Even there is no [Java](https://www.java.com/en/download/) used in this project at first look. You need to install it as well. It is required by Appium and Android. We are almost on half way to success.

### Appium
Appium web driver can be downloaded in two ways: [via terminal](http://appium.io/docs/en/about-appium/getting-started/) or download [a client](https://github.com/appium/appium-desktop/releases/tag/v1.15.1).

I prefer a terminal command. Do not forget to use *appium-doctor*. It helps you to locate a problematic point on your machine as Appium requires a lot of dependencies and correct paths.

### Run project
If you read this section I assume you performed all required actions. To run this project you would need three terminal windows to be open.
1. Emulator:
Open first terminal window and launch the android emulator. By now you should have created one that can be launched by:
> $ /Users/{USER_NAME}/Library/Android/sdk/emulator/emulator -avd avd_name

If you do not know the name of you emulator use this command to find existing emulators:
> $ /Users/{USER_NAME}/Library/Android/sdk/emulator/emulator -list-avds

*NB!* Do not forget to activate [USB debugging](https://www.qafox.com/appium-enabling-debugging-mode-in-android-devices-emulators/) on emulator otherwise Appium won't recognise your device.
To check if devices visible, you run command *adb devices* and you should get status _device_ (if offline - activate usb debugging).
>$ adb devices
>
> List of devices attached
>
> emulator-5554	device

2. Appium:
Open second terminal window and start Appium client by writting next command:
> appium

3. Execute the code:
You will run the code in the last terminal window. I use rspec testing framework to write, run, and generate output report. Navigate to project folder and run the code by the next command:
> $ rspec main_activity_spec.rb

There are 14 testing cases where 2 cases failing. It means the app has defects. If case fails screenshots are made and stored in [/outputs](/outputs) folder.

[List of the test cases](https://github.com/GekkoTheFirst/challenge-one/blob/07c6819c8fddd60c099c5a0d8e1bdb7c479677c2/main_activity_spec.rb#L56):
1. it 'closes the application without crash'
2. it 'launches the application without crash'
3. it 'shows the activity title'
4. it 'shows checked today`s date'
5. it 'shows current in header'
6. it 'shows today`s date in header'
7. it 'shows yesterday`s date in header'
8. it 'shows checked tomorrow`s date after selecting'
9. it 'doesn`t shows checked date last year'
10. it 'shows last year in header after selecting'
11. it 'shows last year date in header after selecting'
12. it 'doesn`t show checked date next year'
13. it 'shows next year in header after selecting'
14. it 'shows next year date in header after selecting'

### License
Appium uses [Apache License 2.0](https://github.com/appium/appium/blob/master/LICENSE)
