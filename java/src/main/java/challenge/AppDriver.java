package challenge;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URL;
import java.time.Duration;
import java.time.LocalDate;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import io.appium.java_client.MobileElement;
import io.appium.java_client.TouchAction;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.MobileCapabilityType;
import io.appium.java_client.touch.WaitOptions;
import io.appium.java_client.touch.offset.PointOption;

public class AppDriver {

    // Android Driver (appium driver)
    private AndroidDriver<MobileElement> driver;
    private WebDriverWait wait;
    // App name and start activity name
    private String PACKAGE = "gmbh.ambidexter.testapplication";
    private String ACTIVITY = "gmbh.ambidexter.testapplication.main.MainActivity";
    // Loading a apk file from resources folder
    private  File apk = new File("../resources/app-debug.apk");
    private String app = apk.getAbsolutePath();
    // Yaml file containing xpath or id app's elements
    private YamlElements yml;
    private Map<String, String> ymlElements;
    // Date
    private LocalDate today = LocalDate.now();

    public AppDriver() throws FileNotFoundException {
        yml = new YamlElements();
        ymlElements = yml.getYmlElements();
    }

    public AndroidDriver setup() throws Exception {
        DesiredCapabilities caps = getCaps("android");
        URL url = new URL("http://0.0.0.0:4723/wd/hub");
        driver = new AndroidDriver<MobileElement>(url, caps);
        return driver;
    }

    private DesiredCapabilities getCaps(String platform){
        DesiredCapabilities caps = new DesiredCapabilities();
        switch (platform) {
            case "ios":
                caps.setCapability(MobileCapabilityType.PLATFORM_NAME, "iOS");
                caps.setCapability(MobileCapabilityType.PLATFORM_VERSION, "13.1");
                caps.setCapability(MobileCapabilityType.DEVICE_NAME, "iOS Emulator");
                caps.setCapability(MobileCapabilityType.APP, app);
                caps.setCapability("appPackage", PACKAGE);
                caps.setCapability("appActivity", ACTIVITY);
            default:
                caps.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
                caps.setCapability(MobileCapabilityType.PLATFORM_VERSION, "7.0");
                caps.setCapability(MobileCapabilityType.DEVICE_NAME, "Android Emulator");
                caps.setCapability(MobileCapabilityType.APP, app);
                caps.setCapability("appPackage", PACKAGE);
                caps.setCapability("appActivity", ACTIVITY);
        }
        return caps;
    }

    // Wait
    public void waiting(int sec) {
        driver.manage().timeouts().implicitlyWait(sec, TimeUnit.SECONDS);
    }

    // CLICKING
    public void clickElementByXpath(String element){
        driver.findElementByXPath(ymlElements.get(element)).click();
    }

    public void clickElementById(String element){
        driver.findElementById(ymlElements.get(element)).click();
    }

    // Looking for xpath element using int: date.
    // Date is needed to select a calendar date elements
    public void clickXpathDate(int day) {
        String s = ymlElements.get("xpath_calendar_text") + "'" + day + "']";
        driver.findElementByXPath(s).click();
    }

    // Looking for xpath element using int: date.
    // Year is needed to select a correct year from the year list
    public void clickXpathYear(int year) {
        String s = ymlElements.get("xpath_year_text") + "'" + year + "']";
        driver.findElementByXPath(s).click();
    }

    // DISPLAYED
    public boolean displayedXpathYear(int year){
        String s = ymlElements.get("xpath_year_text") + "'" + year + "']";
        return driver.findElementByXPath(s).isDisplayed();
    }

    // TEXT
    public String getTextId(String element){
        return driver.findElementById(ymlElements.get(element)).getText();
    }

    public String getTextXpath(String element){
        return driver.findElementByXPath(ymlElements.get(element)).getText();
    }

    // Kill the appium driver
    public void quit(){
        driver.quit();
    }

    // Perform clicking on the desired year/month/date
    public void showDesiredDate(LocalDate date){
        int year = date.getYear();
        int month = date.getMonthValue();
        int day = date.getDayOfMonth();

        clickElementById("id_header_year");
        checkYearVisibility(year);
        clickXpathYear(year);
        waiting(1);
        swipeMonths(month);
        clickXpathDate(day);
    }

    // Default year list visibility state showing previous 2 and next 4 years
    private void checkYearVisibility(int desiredYear){
        int year = today.getYear();
        int diffYear = year - desiredYear;
        // Catch not element exception to scroll list up/down .
        // If diff years < 3 or > 4 year, element is located outside of visible zone,
        // so scrolling needed
        try {
            displayedXpathYear(desiredYear);
        } catch (NoSuchElementException e){
            // We scroll the list many times as difference between current year and expected
            if ((diffYear) > 3) {
                for (int i = 0; i < diffYear; i++){
                    scroll(100, 800, 100, 960);
                }
            } else {
                // We need to substract 3 years from difference as those years are visible by default
                int loop = Math.abs(diffYear) - 3;
                for (int i = 0; i < loop; i++){
                    scroll(100, 800, 100, 640);
                }
            }
        }
    }

    // Scrolling the screen
    private void scroll(int start_x, int start_y, int end_x, int end_y){
        PointOption po = new PointOption();
        WaitOptions wo = new WaitOptions();
        TouchAction ta = new TouchAction(driver);

        ta.press(po.point(start_x, start_y))
                .waitAction(wo.withDuration(Duration.ofSeconds(1)))
                .moveTo(po.point(end_x, end_y))
                .release()
                .perform();
    }

    // Swiping moths by calculating difference between current and given month
    public void swipeMonths(int desiredMonth) {
        int currentMonth = today.getMonthValue();
        int diff = currentMonth - desiredMonth;

        if (currentMonth > desiredMonth){
            switchMonths(diff, "prev");
        } else {
            switchMonths(Math.abs(diff), "next");
        }
    }

    // Helper to move months back and forward.
    // int: month_counter -  amount of months to move calendar
    // string: move - 'prev' moving to the past, 'next' moving to the future
    private void switchMonths(int monthCounter, String move) {
        for (int i = 0; i < monthCounter; i++){
            if (move == "prev") {
                driver.findElementById(ymlElements.get("id_prev")).click();
            } else {
                driver.findElementById(ymlElements.get("id_next")).click();
            }
        }
    }
}
