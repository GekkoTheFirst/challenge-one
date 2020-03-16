require 'appium_lib'

class MainActitivity

  # Getting Env variable from terminal to distiguish between iOS and
  # Androd simulators. If no provided value, it returns "android" string
  def platform?()
    return ENV['PLATFORM'].nil? ? 'android' : ENV['PLATFORM']
  end

  # Selecting
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

  # Appium iOS parameters
  def ios_caps()
    app = 'resources/app-debug.app'
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

  # Start appium driver with predefined parameters
  def start_driver()
    # Selecting opts based on given info
    opts = select_emulator(platform?())
    @appium = Appium::Driver.new(opts, true)
    Appium.promote_appium_methods self.class
    @driver = @appium.start_driver
  end




  def click_next_month()

  end

  def click_prev_month()
    @driver.find_element(:id, @elements['id_prev']).click
  end

  def title_date()
    return @driver.find_element(:id, @elements['id_header_date']).text
  end


end
