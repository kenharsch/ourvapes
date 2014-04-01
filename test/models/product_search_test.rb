require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	describe "full text search" do

		before do
			Product.delete_all
			(1..5).each do |i|
				Wick.create(name: "my wick #{i}", description: "some words #{i}")
				Tank.create(name: "your tank #{i}", description: "totally different, kinda #{i}")
			end
			Button.create(name: "his button", description: "well, not creative today, sorry")
		end

		describe "full text search in products table" do
			it "finds a whole word in the title" do
				search = Product.search {fulltext 'wick'}
				search.total.must_equal 5
				search.results.each {|r| r.must_be_instance_of Wick}

				search = Product.search {fulltext 'his'}
				search.total.must_equal 1
				search.results.each {|r| r.name.must_equal "his button"}
			end
		end
	end
end