# Author : MalloZup

# Some essential steps
# when you test a webpage and server

And(/^I navigate to "([^"]*)"$/) do |page|
    # Capaybara for navigate in webpages, look at:
    # https://gist.github.com/zhengjia/428105
     visit(page)
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

Then(/^^I click "([^"]*)"/) do |link|
 begin
    click_link(link)
  rescue
    # in case of ajax
    sleep 10
    click_link(link)
  end
end

Then(/^^I ping "([^"]*)"/) do |server|
 wasGood = system("ping -c1 #{server}")
 unless wasGood
   raise "ping failed!"
 end
end
