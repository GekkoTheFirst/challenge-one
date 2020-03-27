# NOTE:
# Select any date on Android app
require_relative 'appium_driver'
require 'date'

class DatePicker

  def initialize(date)
    @driver = AppiumDriver.new()
    @driver.start_driver()
    @date = date
  end

  def extract_year()
    return @date.year
  end

  def extract_month()
    return @date.month
  end

  def extract_day()
    return @date.day
  end

  # Checks if year is visible on the screen if not scroll up or down.
  # Visible years between previous two and next four
  def check_year_visibility()
    current_year = DateTime.now.year
    if (current_year - @date.year) <= 0 && (current_year - @date.year) >= -5
      # Comment "no swipe needed"
    elsif (current_year - @date.year) > 5
      swipe_year(2, 'up')
    elsif (current_year - @date.year) > 0 && (current_year - @date.year) <= 5
      swipe_year(1, 'up')
    elsif (current_year - @date.year) < -5 && (current_year - @date.year) >= -8
      swipe_year(1, 'down')
    elsif (current_year - @date.year) < -8
      swipe_year(2, 'down')
    else
    end
  end

  # Swipe up & down year list
  def swipe_year(n, navigation)
    n.times do
      if navigation.eql?('up')
        @driver.scroll_year_up()
      else
        @driver.scroll_year_down()
      end
    end
  end

  def swipe_month()
    currnet_month = DateTime.now.month
    diff = currnet_month - extract_month()

    if currnet_month > extract_month()
      @driver.swtich_months(diff, 'prev')
    else
      @driver.swtich_months(diff.abs, 'next')
    end
  end

  # Select year (if year is located outside of visible zone - scrolling).
  # After year is selected date and month are selected based on current month
  def select_date()
    # Select year
    @driver.id_element_click('id_header_year')
    check_year_visibility()
    @driver.xpath_year_click(extract_year())
    # Select month
    swipe_month()
    # Select day
    @driver.xpath_date_click(extract_day())
  end

  # Check if given date is selected
  def check_result?()
    year = @driver.id_element_get_text('id_header_year').to_i
    month = @driver.id_element_get_text('id_header_date')[5..8]
    day = @driver.xpath_day_get_text(@date.day).to_i
    if (@date.year == year) && (month.include?(@date.strftime('%b'))) && (@date.day == day)
      true
    else
      false
    end
  end

  # Kills the appium web driver
  def stop_driver()
    @driver.driver_quit()
  end
end


begin
  date = Date.parse("#{ARGV}")
  years_13 = 13
  min_year = DateTime.now.year - years_13
  max_year = DateTime.now.year + years_13

  # Checking supported years
  if date.year >= min_year && date.year <= max_year
    s = DatePicker.new(date)
    s.select_date()
    puts " --------- "
    puts s.check_result?() ? "Test passed" : "Test Failed"
    puts " --------- "
    s.stop_driver()
  else
    puts "NB!!! Algorithm works between #{min_year} and #{max_year} years"
    exit 1
  end

rescue ArgumentError
  puts "Please check date input format: yyyy-mm-dd where y - year; m - month; d - day. Example for 31 January 2000: 2000-01-31"
end
