# Ruby project
It has two solutions: 1 - select a date from a date picker. 2 - run a test suite.

## Preparation for running
To run this project you would need three terminal windows to be open.
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
Open second terminal window and start Appium client by writing next command:
> appium

3. Execute the code:
You will run the code in the last terminal window. There are two solutions, so use right one to run wanted output.

### Run the date picker
Use _date_picker.rb_ ruby file to run, and generate output report. To select a date the date need to be written in next format: _yyyy-mm-dd_. Now navigate to project folder and run the code by the next command:
> $ ruby data_picker.rb yyyy-mm-dd

### Run the test suite
I use rspec testing framework to write, run, and generate output report. Navigate to project folder and run the code by the next command:
> $ rspec main_activity_spec.rb

There are 16 testing cases where 2 cases failing. It means the app has defects. If case fails screenshots are made and stored in [/outputs](/outputs) folder.

[List of the test cases](https://github.com/GekkoTheFirst/challenge-one/blob/07c6819c8fddd60c099c5a0d8e1bdb7c479677c2/main_activity_spec.rb#L56):
1. it 'closes the application without crash'
2. it 'launches the application without crash'
3. it 'shows the activity title'
4. it 'shows checked today`s date'
5. it 'shows current in header'
6. it 'shows today`s date in header'
7. it 'shows yesterday`s date in header'
8. it 'shows checked tomorrow`s date after selecting'
9. it 'shows last month in header'
10. it 'shows next month in header'
11. it 'doesn`t shows checked date last year' # Scenario failing
12. it 'shows last year in header after selecting'
13. it 'shows last year date in header after selecting'
14. it 'doesn`t show checked date next year' # Scenario failing
15. it 'shows next year in header after selecting'
16. it 'shows next year date in header after selecting'
