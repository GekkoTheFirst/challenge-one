# Java project:

## Preparation for running
To run this project you would need three terminal windows or IDE.
1. Emulator:
Easy Way:
Open project in an IDE and create an emulator in IDE (I used Android studio).

Hard Way:
We assume you have avd installed and emulators configured. 
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

2. Appium:
Open second terminal window and start Appium client by writing next command:
> appium

3. Execute the code:
Before run you need to set up right android version that you can find in Settings on your emulator or physical devices. Go to [AppDriver](https://github.com/GekkoTheFirst/challenge-one/java/src/main/java/challenge/AppDriver.java#L63)
and change _caps.setCapability(MobileCapabilityType.PLATFORM_VERSION, "8.0")_ according to your Android device or emulator version.
I have tested the app on Android 7.0 (API 24), 8 (API 26) and 9 (API 28).

To edit or set the data can done directly in file before the run [AppTest](https://github.com/GekkoTheFirst/challenge-one/java/test/java/challenge/AppTest.java#L31).
If you want to run code from IDEA, navigate run AppTest and click run. If you want to run code in terminal:
> $ gradle test

