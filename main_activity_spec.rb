# NOTE:
# Main

RSpec.describe "MainActitivity" do
  require 'date'
  require 'yaml'
  require 'rspec'
  require_relative 'main_activity'

  # Global hook to create an appium web driver, YAML and Time objects
  before(:all) do
    # Appium driver
    @driver = MainActitivity.new()
    @driver.start_driver()
    # Today's date object
    @today = Date.today()
    @yesterday = @today.next_day()
    @tomorrow = @today.next_day()
    @prev_year = @today.prev_year()
    @next_year = @today.next_year()
    # YMAL object containing xpath and id elements
    @elements = YAML.load_file('mobile_elements.yml')
  end

  # Helper to move months back and forward.
  # int: mounth_counter -  amount of mounts to movement
  # string: movement - 'prev' moving to the past, 'next' moving to the future
  def swtich_months(mounth_counter, movement)
    mounth_counter.times do
      if movement.eql?('prev')
        @driver.find_element(:id, @elements['id_prev']).click
      else
        @driver.find_element(:id, @elements['id_next']).click
      end
    end
  end

  # Before each hooks set a unix time to distiguish failing scenarios
  before(:each) do
    @unix_time = Time.now.to_i
  end

  # After each hook if scenario has exception or fails then screenshot created
  after(:each) do |example|
    if example.exception
      @driver.save_viewport_screenshot("outputs/#{@unix_time}.png")
    end
  end

    # Section related to "now" time
    describe "interactions with current month elements" do

      it 'closes the application without crash' do
        @driver.close_app
        package = @driver.current_package

        expect(package).not_to eq(@elements['app_package'])
      end

      it 'launches the application without crash' do
        @driver.launch_app
        package = @driver.current_package

        expect(package).to eq(@elements['app_package'])
      end

      it 'shows the activity title' do
        title = @driver.find_element(:xpath, @elements['xpath_app_name']).text

        expect(title).to eq(@elements['app_name'])
      end

      it 'shows checked today`s date' do
        checked = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@today.day}']").checked?()

        expect(checked).to eq("true")
      end

      it 'shows current in header' do
        date = @driver.find_element(:id, @elements['id_header_year']).text

        expect(date).to eq("#{@today.year}")
      end

      it 'shows today`s date in header' do
        date = @driver.find_element(:id, @elements['id_header_date']).text

        expect(date).to eq(@today.strftime('%a, %b %d'))
      end

      it 'shows yesterday`s date in header' do
        select = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@yesterday.day}']").click
        checked = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@yesterday.day}']").checked?()

        expect(checked).to eq("true")
      end

      it 'shows checked tomorrow`s date after selecting' do
        select = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@tomorrow.day}']").click
        checked = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@tomorrow.day}']").checked?()

        expect(checked).to eq("true")
      end
    end

    # Section related to past time
    describe "interactions with previous year elements" do
      # New session starts and kill previoius session to increase speed of tests
      before(:all) do
        @driver.start_driver()
        swtich_months(12, 'prev')
      end

      it 'doesn`t shows checked date last year' do # Scenario failing
        checked = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@today.day}']").checked?()

        expect(checked).to eq("false")
      end

      it 'shows last year in header after selecting' do
        select = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@today.day}']").click
        year = @driver.find_element(:id, @elements['id_header_year']).text

        expect(year).to eq("#{@prev_year.year}")
      end

      it 'shows last year date in header after selecting' do
        select = @driver.find_element(:xpath,
          "#{@elements['xpath_calendar_text']}'#{@today.day}']").click
        date = @driver.find_element(:id, @elements['id_header_date']).text

        expect(date).to eq(@prev_year.strftime('%a, %b %d'))
      end
    end

    # Section related to futur time
    describe "interaction with next year elements" do
      # New session starts and kill previoius session to increase speed of tests
      before(:all) do
        @driver.start_driver()
        swtich_months(12, 'next')
      end
      # Kills the session
      after(:all) do
        @driver.quit()
      end

      it 'doesn`t show checked date next year' do # Scenario failing
        checked = @driver.find_element(:xpath,
            "#{@elements['xpath_calendar_text']}'#{@today.day}']").checked?()

        expect(checked).to eq("false")
      end

      it 'shows next year in header after selecting' do
        select = @driver.find_element(:xpath,
            "#{@elements['xpath_calendar_text']}'#{@today.day}']").click
        year = @driver.find_element(:id, @elements['id_header_year']).text

        expect(year).to eq("#{@next_year.year}")
      end

      it 'shows next year date in header after selecting' do
        select = @driver.find_element(:xpath,
          "//android.view.View[@text='#{@today.day}']").click
        date = @driver.find_element(:id, @elements['id_header_date']).text

        expect(date).to eq(@next_year.strftime('%a, %b %d'))
      end
    end
end
