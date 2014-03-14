require 'test_helper'
require 'minitest/autorun'

class BatteryTest < ActiveSupport::TestCase
	describe "battery" do
		Battery.count.must_be 1
	end
end
