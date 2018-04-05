# Isaiah Grigsby
# April 5, 2018

require "rubygems"
require "selenium-webdriver"
require "csv"

driver = Selenium::WebDriver.for :safari
driver.navigate.to 'http://mailchimp.com'

    if driver.title == 'Marketing Automation - Sell More Stuff | MailChimp' # This checks to see if this title is valid
  puts 'Test 1: Pass : Title Found'

    else
  puts 'Test 1 : Failed' # Prints out if validation failed

  sleep 5

    end

f = driver.page_source
    if f.include?("MailChimp")                 # Checks page source to see if its the right value
    puts 'Test 2: Pass: Website Found'

    else
    puts 'Test 2: Failed'

    sleep 5

  end

a = driver.find_element(:link, 'About MailChimp') # Find link element on current page
a.click                                           # Clicks on link
    if f.include?('About MailChimp')
  puts 'Test 3: Pass next link checked'
  driver.get "http://mailchimp.com/about"

    else
  puts 'Test 3 : failed'

  sleep 5
    end


elements = driver.find_elements(:class_name, "bio_link") # Method checks class 'bio_link' within html code

  puts elements[2].text

  limit = elements.length


CSV.open('test.csv', 'wb',) do |csv|      # Creates csv file
  for i in 0..(limit-1)                   # Sets length of list
    list = []
    data_position = elements[i].attribute("data-position")  # Retrieves attributes from element
    data_title = elements[i].attribute("data-title")
    data_description = elements[i].attribute("data-description")
    list.insert(0, data_position)                           # Populates list to create csv
    list.insert(1, data_title)
    list.insert(2, data_description)
    csv << list                         # Exports information to csv file

  end

driver.quit

end


