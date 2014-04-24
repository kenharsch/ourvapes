require 'test_helper'

class ProdSearchTest < ActiveSupport::TestCase

	before do
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

		update_solr_indices
	end


	describe "results sorting" do

		it "shows title matchings higher than description matchings" do
			ProdSearch.full_text('VapeRater', nil, nil, nil) do |results, manu_facets|
				results[0].name.must_equal "keyword VapeRater in name"
			end
		end
	end
end