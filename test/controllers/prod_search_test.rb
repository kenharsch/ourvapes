require 'test_helper'

class ProdSearchTest < ActiveSupport::TestCase

	setup do
		# clear and fill the test database
		Product.destroy_all

		5.times do
			Wick.create(
				name: "no keyword in name",
				description: "but here we have VapeRater is in the description")
		end

		Wick.create(
			name: "keyword VapeRater in name",
			description: "something without the important keyword")

		5.times do
			Wick.create(
				name: "and the other way around",
				description: "where VapeRater is in the description again")
		end

		# binding.pry

		# update solr indices / should run without reindexing every time
		# Product.reindex
		# Sunspot.commit
	end


	describe "results sorting" do

		it "shows title matchings higher than description matchings" do
			search = ProdSearch.full_text('VapeRater')
			# binding.pry
			search.total.must_equal 11
			search.results[0].name.must_equal "keyword VapeRater in name"
		end
	end
end