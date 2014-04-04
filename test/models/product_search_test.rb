require 'test_helper'

class ProductTest < ActiveSupport::TestCase

	describe "full text search in name and description" do

		before do
			# clear and fill the test database
			Product.destroy_all

			(1..5).each do |i|
				Wick.create(name: "my wick #{i}", description: "some words #{i}")
				Tank.create(name: "your tank #{i}", description: "totally different, kinda #{i}")
			end

			Button.create(name: "his button", description: "well, not creative today, sorry")
			Button.create(name: "his other button", description: "well, not creative today, sorry")

			Wick.create(name: "some Wick with uppercase name")

			update_solr_indices
		end

		it "finds with one matching word in the name" do
			search = Product.search {fulltext 'tank'} # does not work with double quotes

			search.total.must_equal 5
			search.results.each {|r| r.must_be_instance_of Tank}

			search = Product.search {fulltext 'his'}

			search.total.must_equal 2
			search.results.each {|r| r.description.must_equal "well, not creative today, sorry"}

			search = Product.search {fulltext '4'}
			search.total.must_equal 2
		end

		# it "finds a part of a word in the name" do
		# 	search = Product.search {fulltext 'utto'}
		# 	search.total.must_equal 1
		# 	search.results.each {|r| r.name.must_equal "his button"}
		# end

		it "finds with multiple matching words in the name" do
			search = Product.search {fulltext 'your tank 3'}
			search.total.must_equal 1
			search.results.each {|r| r.name.must_equal "your tank 3"}
		end

		it "finds with multiple matching words in wrong order the name" do
			search = Product.search {fulltext 'tank 3 your'}
			search.total.must_equal 1

			search = Product.search {fulltext 'tank your'}
			search.total.must_equal 5
		end

		it "finds with multiple words in wrong order in description" do
			search = Product.search {fulltext 'creative not'}
			search.total.must_equal 2
			search.results.each {|r| r.must_be_instance_of Button}
		end

		it "finds with some words in name and others in description" do
			search = Product.search {fulltext 'sorry well other his'}
			search.total.must_equal 1
			search.results[0].name.must_equal "his other button"
		end

		it "finds nothing if there is nothing matching" do
			search = Product.search {fulltext 'tanks 3 your'}
			search.total.must_equal 1
		end

		it "ignores commata" do
			search = Product.search {fulltext 'different kinda'}
			search.total.must_equal 5
			search.results.each {|r| r.must_be_instance_of Tank}
		end


		it "ignores cases" do
			search = Product.search {fulltext 'wick'}
			search.total.must_equal 6
			search.results.each {|r| r.must_be_instance_of Wick}
		end
	end

	describe "fulltext search in manufacturer and type" do

		before do
			Product.destroy_all

			Wick.create(name: "XY1", manufacturer: "Viva La Vape")
			Wick.create(name: "XY2", manufacturer: "Viva La Vape")
			Tank.create(name: "V2", manufacturer: "Vapers Heaven")

			update_solr_indices
		end

		it "searches in manufacturer" do
			search = Product.search {fulltext "viva la"}
			search.total.must_equal 2
			search.results.each {|r| r.must_be_instance_of Wick}

			search = Product.search {fulltext "heaven"}
			search.total.must_equal 1
			search.results[0].must_be_instance_of Tank
		end

		it "searches in type" do
			search = Product.search {fulltext "wick"}

			search.total.must_equal 2
			search.results.each {|r| r.must_be_instance_of Wick}

			search = Product.search {fulltext "tank"}
			search.total.must_equal 1
			search.results[0].must_be_instance_of Tank
		end
	end
end