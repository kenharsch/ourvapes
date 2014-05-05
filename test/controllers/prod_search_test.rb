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
	end


	describe "ranking" do

		it "shows title matchings higher than description matchings" do
			update_solr_indices

			search = ProdSearch.full_text('VapeRater', nil, nil, nil, nil, nil)
			search.results[0].must_equal @vr_wick
		end

	end

	describe "compatibility filtering" do
		before do
			@t = Tank.create

			@my_config = MyConfig.new
			@my_config.add_by_id(@t.id)
		end

		it "filters if compatibility filter enabled" do
			@t.set_compat_with(@vr_wick, CompatPair::WORKS_WELL)

			update_solr_indices

			search = ProdSearch.full_text(nil, [CompatPair::WORKS_WELL],
				nil, nil, @my_config, nil)

			search.results.size.must_equal 1
			search.results[0].must_equal @vr_wick
		end

		# it "lets products pass if no compat rule affects them with the current MyConfig" do
		# 	# there is a rule checking tank-wick compatibility; there is a tank in MyConfig
		# 	# which is not set as compatible to anything
		# 	# therefore none of the wicks should pass the WORKS_WELL compat. filter;
		# 	# however there is no rule for tank-battery checking; therefore the battery
		# 	# is the only product which should pass the filter
		# 	b = Battery.create

		# 	update_solr_indices

		# 	search = ProdSearch.full_text(nil, [CompatPair::WORKS_WELL],
		# 		nil, nil, @my_config, nil)

		# 	search.results.size.must_equal 1
		# 	search.results[0].must_equal b
		# end
	end
end