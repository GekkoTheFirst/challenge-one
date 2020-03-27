# NOTE:
# Appium driver related to MainActivity screen
require 'appium_lib'
require 'yaml'

class AppiumDriver

  # Getting Env variable from terminal to distiguish between iOS and
  # Androd simulators. If no provided value, it returns "android" string
  def platform?()
    return ENV['PLATFORM'].nil? ? 'android' : ENV['PLATFORM']
  end

  def initialize()
    # YMAL object containing xpath and id elements
    @yml_element = YAML.load_file('../resources/mobile_elements.yml')

    # Selecting opts based on given info
    opts = select_emulator(platform?())
    @appium = Appium::Driver.new(opts, true)
    Appium.promote_appium_methods self.class
  end

  # Selecting platform
  def select_emulator(platform)
    case platform.downcase()
    when 'ios'
      ios_caps()
    else
      android_caps()
    end
  end

  # Appium android parameters
  def android_caps()
    app = '../resources/app-debug.apk'
    return { caps: {
                platformName:  'Android',
                deviceName:    'Pixel Simulator',
                app:           app,
                appPackage:    'gmbh.ambidexter.testapplication',
                appActivity:   'gmbh.ambidexter.testapplication.main.MainActivity',
                automationName:'UiAutomator2'
              },
              appium_lib: {
                wait_timeout: 5,
              }
    }
  end

  # Appium iOS parameters. It doesn't work as there is no app file in this project
  def ios_caps()
    app = 'APP FILE PATH'
    return { caps: {
                platformName:  'iOS',
                platformVersion: "13.1",
                deviceName:    'iOS Simulator',
                app:           app,
                automationName:'XCUITest'
              },
              appium_lib: {
                wait_timeout: 5,
              }
    }
  end

  # Helper to move months back and forward.
  # int: month_counter -  amount of months to move calendar
  # string: move - 'prev' moving to the past, 'next' moving to the future
  def swtich_months(month_counter, move)
    month_counter.times do
      if move.eql?('prev')
        @appium.find_element(:id, @yml_element['id_prev']).click
      else
        @appium.find_element(:id, @yml_element['id_next']).click
      end
    end
  end

  # Waiting for 5 seconds
  def wait
    Selenium::WebDriver::Wait.new(:timeout => 5)
  end

### CLICK ###

  # Looking for id element and clicks that element
  # string: name - id or xpath name taken from mobile_elements.yml
  def id_element_click(name)
    @appium.find_element(:id, @yml_element[name]).click
  end

  # Looking for xpath element and clicks that element
  # string: name - id or xpath name taken from mobile_elements.yml
  def xpath_element_click(name)
    @appium.find_element(:xpath, @yml_element[name]).click
  end

  # Looking for id element using int: date.
  # Date is needed to distiguish between calendar date elements
  def id_date_click(day)
    @appium.find_element(
      :id, "#{@yml_element['xpath_calendar_text']}'#{day}']").click
  end

  # Looking for xpath element using int: date.
  # Date is needed to distiguish between calendar date elements
  def xpath_date_click(day)
    @appium.find_element(
      :xpath, "#{@yml_element['xpath_calendar_text']}'#{day}']").click
  end

  # Looking for xpath element using int: date.
  # Year is needed to distiguish between calendar date elements
  def xpath_year_click(year)
    @appium.find_element(
      :xpath, "#{@yml_element['xpath_year_text']}'#{year}']").click
  end

### SCROLL ###
  # Swiping the screen by x and y coordinates
  def swipe(start_x, start_y, end_x, end_y)
    action = TouchAction.new(@appium).swipe(start_x, start_y, end_x, end_y)
    action.perform()
  end

  # Waititng to scrolling areat to show up and scroll down
  def scroll_year_up()
    sleep(1)

    swipe(start_x: 100, start_y: 1000, end_x: 100, end_y: 1350)
  end

  # Waititng to scrolling areat to show up and scroll up
  def scroll_year_down()
    sleep(1)

    swipe(start_x: 100, start_y: 1000, end_x: 100, end_y: 650)
  end

### CHECKED? ###

  # Looking for id element using int: date.
  # Date is needed to distiguish between calendar date elements.
  # Returning true if element's checked attribute is true
  def id_date_checked?(day)
    return @appium.find_element(
      :id, "#{@yml_element['xpath_calendar_text']}'#{day}']").checked?
  end

  # Looking for xpath element using int: date.
  # Date is needed to distiguish between calendar date elements.
  # Returning true if element's checked attribute is true
  def xpath_date_checked?(day)
    return @appium.find_element(
      :xpath, "#{@yml_element['xpath_calendar_text']}'#{day}']").checked?
  end

### DISPLAYED? ###

  # Lookong for element by id and return true if elemenet displayed
  def id_element_displayed?(year)
    return @appium.find_element(:id, @yml_element['xpath_year_text']).displayed?
  end

  # Lookong for element by id and return true if elemenet displayed
  def id_year_displayed?(year)
    return @appium.find_element(
      :id, "#{@yml_element['xpath_year_text']}'#{year}']").displayed?
  end

  # Lookong for element by xpath and return true if elemenet displayed
  def xpath_year_displayed?(year)
    return @appium.find_element(
      :xpath, "#{@yml_element['xpath_year_text']}'#{year}']").displayed?
  end

### TEXT ###

  # Looking for id element and return text
  # string: name - id name taken from mobile_elements.yml
  def id_element_get_text(name)
    return @appium.find_element(:id, @yml_element[name]).text
  end

  # Looking for xpat element and return text
  # string: name - xpath name taken from mobile_elements.yml
  def xpath_element_get_text(name)
    return @appium.find_element(:xpath, @yml_element[name]).text
  end

  # Lookong for day by xpath and return text of the cell
  def xpath_day_get_text(day)
    return @appium.find_element(
      :xpath, "#{@yml_element['xpath_calendar_text']}'#{day}']").text
  end

end
