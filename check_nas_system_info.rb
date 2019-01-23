require "selenium-webdriver"

url = ENV["OMW_URL"]
username = ENV["OMW_username"]
password = ENV["OMW_password"]

# options = Selenium::WebDriver::Chrome::Options.new(args: %w('ignore-certificate-errors', '--disable-dev-shm-usage', '--headless'))
options = ::Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
options.add_argument('--ignore-certificate-errors')

@browser = Selenium::WebDriver.for :chrome, options: options
@browser.get url
@browser.find_element(id: "username-inputEl").send_keys username
@browser.find_element(id: "password-inputEl").send_keys password
@browser.find_element(xpath: "//a[contains(.,'Login')]").click
sleep 5
@browser.find_element(xpath: "//a[.='Diagnostics']").click
sleep 5
@browser.find_elements(xpath: "//span[.='System Information']")[1].click
sleep 5

@browser.quit