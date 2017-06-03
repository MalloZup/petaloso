# Author : MalloZup

# Some essential steps
# when you test a webpage and server

And(/^I navigate to "([^"]*)"$/) do |page|
    # Capaybara for navigate in webpages, look at:
    # https://gist.github.com/zhengjia/428105
     visit("https://#{page}")
end

#
## Test for a text in the whole page
##

Then(/^I should see a "([^"]*)" text$/) do |text|
 unless page.has_content?(text)
   sleep 25 # in case of ajax loading
   fail unless page.has_content?(text)
 end
end

#
# Test for a text not allowed in the whole page
#
Then(/^I should not see a "([^"]*)" text$/) do |text|
  unless page.has_no_content?(text)
    print page.body
    raise "#{text} found on the page! FAIL"
  end
end

# this is only for demo, normally you take screenshot
# only if something fails.
# https://github.com/teampoltergeist/poltergeist
Then(/^I take a screenshot$/) do
  save_screenshot('/tmp/wowscreen.png', :full => true)
end

# https://github.com/teampoltergeist/poltergeist
Then(/^^I click "([^"]*)"/) do |link|
 begin
    click(link)
  rescue
    # in case of ajax
    sleep 10
    click(link)
  end
end

Then(/^^I ping "([^"]*)"/) do |server|
 wasGood = system("ping -c4 #{server}")
 unless wasGood
   raise "ping failed!"
 end
end
