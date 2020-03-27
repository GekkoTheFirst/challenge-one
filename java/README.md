# Ruby project:
It has two solutions: 1 - select a date from a date picker. 2 - run a test suite.

## Preparation for running
To run this project you would need three terminal windows to be open.
1. Emulator:
Easy Way:
Create emulator in IDE (e.g. Android studio) and run code via IDE.

Hard Way:
Open first terminal window and launch the android emulator. By now you should have created one that can be launched by:
> $ /Users/{USER_NAME}/Library/Android/sdk/emulator/emulator -avd avd_name

If you do not know the name of you emulator use this command to find existing emulators:
> $ /Users/{USER_NAME}/Library/Android/sdk/emulator/emulator -list-avds

To check if devices visible, you run command *adb devices* and you should get status _device_ (if offline - activate usb debugging).
>$ adb devices
>
> List of devices attached
>
> emulator-5554	device

You need to set up right android version in code before running the app. Go to [AppDriver](https://github.com/GekkoTheFirst/challenge-one/java/src/main/java/challenge/AppDriver.java#L63)
and change _caps.setCapability(MobileCapabilityType.PLATFORM_VERSION, "8.0")_ according to your Android device or emulator version.
I have tested the app on Android 7 (API 24), 8 (API 26) and 9 (API 28).

2. Appium:
Open second terminal window and start Appium client by writing next command:
> appium

3. Execute the code:
Set the data can done in [AppTest](https://github.com/GekkoTheFirst/challenge-one/java/test/java/challenge/AppTest.java#L31).
If you want tu run code from IDEA, navigate run AppTest and click run. If you want to run code in terminal:
> $ gradle test

