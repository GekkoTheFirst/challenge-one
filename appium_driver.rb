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
    @yml_element = YAML.load_file('mobile_elements.yml')

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
    app = 'resources/app-debug.apk'
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
  # int: mounth_counter -  amount of mounts to move calendar
  # string: movement - 'prev' moving to the past, 'next' moving to the future
  def swtich_months(mounth_counter, movement)
    mounth_counter.times do
      if movement.eql?('prev')
        @appium.find_element(:id, @yml_element['id_prev']).click
      else
        @appium.find_element(:id, @yml_element['id_next']).click
      end
    end
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
    @appium.find_element(:id,
      "#{@yml_element['xpath_calendar_text']}'#{day}']").click
  end

  # Looking for id element using int: date.
  # Date is needed to distiguish between calendar date elements
  def xpath_date_click(day)
    @appium.find_element(:xpath,
      "#{@yml_element['xpath_calendar_text']}'#{day}']").click
  end

### CHECKED? ###

  # Looking for id element using int: date.
  # Date is needed to distiguish between calendar date elements.
  # Returning true if element's checked attribute is true
  def id_date_checked?(day)
    return @appium.find_element(:id,
      "#{@yml_element['xpath_calendar_text']}'#{day}']").checked?
  end

  # Looking for xpath element using int: date.
  # Date is needed to distiguish between calendar date elements.
  # Returning true if element's checked attribute is true
  def xpath_date_checked?(day)
    return @appium.find_element(:xpath,
      "#{@yml_element['xpath_calendar_text']}'#{day}']").checked?
  end

### TEXT ###

  # Looking for id element and return text
  # string: name - id or xpath name taken from mobile_elements.yml
  def id_element_get_text(name)
    return @appium.find_element(:id, @yml_element[name]).text
  end

  # Looking for xpat element and return text
  # string: name - id or xpath name taken from mobile_elements.yml
  def xpath_element_get_text(name)
    return @appium.find_element(:xpath, @yml_element[name]).text
  end

end
