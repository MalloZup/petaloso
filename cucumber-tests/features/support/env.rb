require 'rubygems'
require 'tmpdir'
require 'base64'
require 'capybara'
require 'capybara/cucumber'
require 'simplecov'
require 'capybara/poltergeist'
SimpleCov.start

require 'minitest/unit'
World(MiniTest::Assertions)

def restart_phantomjs
  session_pool = Capybara.send('session_pool')
  session_pool.each do |_mode, session|
    driver = session.driver
    driver.restart if driver.is_a?(Capybara::Poltergeist::Driver)
  end
end

# basic support for rebranding of strings in the UI
DEFAULT_TIMEOUT = 200

$stdout.sync = true
Capybara.default_wait_time = 10

# Setup browser: phantomjs
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
                                    :phantomjs_options => ['--debug=no',
                                                           '--ignore-ssl-errors=yes',
                                                           '--ssl-protocol=TLSv1',
                                                           '--web-security=false'],
                                    :js_errors => false,
                                    :timeout => 250,
                                    :window_size => [1920, 1080],
                                    :debug => false)
end
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

# don't run own server on a random port
Capybara.run_server = false

# screenshots
After do |scenario|
  if scenario.failed?
    encoded_img = page.driver.render_base64(:png, :full => true)
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end
end

# restart always before each feature, we spare ram and
# avoid ram issues!
Before do
  restart_phantomjs
end
