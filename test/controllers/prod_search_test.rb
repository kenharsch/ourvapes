require 'test_helper'

class ProdSearchTest < ActiveSupport::TestCase

	before do
		5.times do
			Wick.create(
				name: "no keyword in name",
				description: "but here we have VapeRater is in the description")
		end

		@vr_wick = Wick.create(
			name: "keyword VapeRater in name",
			description: "something without the important keyword")

		5.times do
			Wick.create(
				name: "and the other way around",
				description: "where VapeRater is in the description again")
		end

		update_solr_indices
	end


	describe "product search" do

		it "shows title matchings higher than description matchings" do
			ProdSearch.full_text('VapeRater', nil, nil, nil, nil, nil) do |results, manu_facets|
				results[0].must_equal @vr_wick
			end
		end

		it "filters by compatibility" do
			t = Tank.create
			t.set_compat_with(@vr_wick, CompatPair::WORKS_WELL)

			my_config = MyConfig.new
			my_config.add_by_id(t.id)

			ProdSearch.full_text(nil, [CompatPair::WORKS_WELL],
				nil, nil, my_config, nil) do |results, manu_facets|

				results.size.must_equal 1
				results[0].must_equal @vr_wick
			end
		end
	end
end