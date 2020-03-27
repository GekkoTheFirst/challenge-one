# NOTE:
# Testing MainActivity screen.
# Run test using rspec framework use next command rspec main_activity_spec.rb
require 'date'
require 'yaml'
require 'rspec'
require_relative 'appium_driver'

RSpec.describe AppiumDriver do

  # Global hook to start an appium webdriver, YAML and Time objects
  before(:all) do
    # Appium driver
    @driver = AppiumDriver.new()
    @driver.start_driver()
    # Today's date object
    @today = Date.today()
    @yesterday = @today.next_day()
    @tomorrow = @today.next_day()
    @prev_year = @today.prev_year()
    @next_year = @today.next_year()
    # YMAL object containing xpath and id elements
    @yml_element = YAML.load_file('../resources/mobile_elements.yml')
  end

  # Before each hooks set a unix time to distiguish failing scenarios
  before(:each) do
    @unix_time = Time.now.to_i
  end

  # After each hook if scenario has exception or fails then screenshot created
  after(:each) do |example|
    if example.exception
      @driver.screenshot("outputs/#{@unix_time}.png")
    end
  end

  # Global hook to stop the session
  after(:all) do
    @driver.driver_quit()
  end

    # Section related to "now" time
    describe "interactions with current month elements" do

      it 'closes the application without crash' do
        @driver.close_app
        package = @driver.current_package

        expect(package).not_to eq(@yml_element['app_package'])
      end

      it 'launches the application without crash' do
        @driver.launch_app
        package = @driver.current_package

        expect(package).to eq(@yml_element['app_package'])
      end

      it 'shows the activity title' do
        title = @driver.xpath_element_get_text('xpath_app_name')

        expect(title).to eq(@yml_element['app_name'])
      end

      it 'shows checked today`s date' do
        check = @driver.xpath_date_checked?(@today.day)

        expect(check).to eq("true")
      end

      it 'shows current year in header' do
        date = @driver.id_element_get_text('id_header_year')

        expect(date).to eq("#{@today.year}")
      end

      it 'shows today`s date in header' do
        date = @driver.id_element_get_text('id_header_date')

        expect(date).to eq(@today.strftime('%a, %b %d'))
      end

      it 'shows yesterday`s date in header' do
        select = @driver.xpath_date_click(@yesterday.day)
        check = @driver.xpath_date_checked?(@yesterday.day)

        expect(check).to eq("true")
      end

      it 'shows checked tomorrow`s date after selecting' do
        select = @driver.xpath_date_click(@tomorrow.day)
        check = @driver.xpath_date_checked?(@tomorrow.day)

        expect(check).to eq("true")
      end

      it 'shows last month in header' do
        select = @driver.swtich_months(1, 'prev')
        check = @driver.xpath_date_checked?(@today.day)

        expect(check).to eq('false')
      end

      it 'shows next month in header' do
        select = @driver.swtich_months(2, 'next')
        check = @driver.xpath_date_checked?(@today.day)

        expect(check).to eq("false")
      end

    end

    # Past time section
    describe "interactions with previous year elements" do
      # Driver restarted to increase speed of tests
      before(:all) do
        @driver.restart()
        @driver.id_element_click('id_header_year')
        @driver.xpath_year_click(@prev_year.year)
      end

      it 'doesn`t shows checked date last year' do # Scenario failing
        check = @driver.xpath_date_checked?(@today.day)

        expect(check).to eq("false")
      end

      it 'shows last year in header after selecting' do
        select = @driver.xpath_date_click(@today.day)
        year = @driver.id_element_get_text('id_header_year')

        expect(year).to eq("#{@prev_year.year}")
      end

      it 'shows last year date in header after selecting' do
        select = @driver.xpath_date_click(@today.day)
        date = @driver.id_element_get_text('id_header_date')

        expect(date).to eq(@prev_year.strftime('%a, %b %d'))
      end
    end

    # Future time section
    describe "interaction with next year elements" do
      # Driver restarted to increase speed of tests
      before(:all) do
        @driver.restart()
        @driver.id_element_click('id_header_year')
        @driver.xpath_year_click(@next_year.year)
      end

      it 'doesn`t show checked date next year' do # Scenario failing
        check = @driver.xpath_date_checked?(@today.day)

        expect(check).to eq("false")
      end

      it 'shows next year in header after selecting' do
        select = @driver.xpath_date_click(@today.day)
        year = @driver.id_element_get_text('id_header_year')

        expect(year).to eq("#{@next_year.year}")
      end

      it 'shows next year date in header after selecting' do
        select = @driver.xpath_date_click(@today.day)
        date = @driver.id_element_get_text('id_header_date')

        expect(date).to eq(@next_year.strftime('%a, %b %d'))
      end
    end
end
