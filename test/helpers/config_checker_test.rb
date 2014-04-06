require "test_helper"

class ConfigCheckerTest < ActionView::TestCase

	KIT_PART_TYPES = [:mouthpiece, :tank, :wick, :button, :battery, :charger]

	describe "everything works well" do
		before do
			t = Tank.create()
			w = Wick.create()
			t.set_compat_with(w, CompatPair::WORKS_WELL)

			kit = Kit.new
			kit.tank = t
			kit.wick = w

			@checker = ConfigChecker.new(kit)
		end

		it "returns empty compatibility conflict lists for each type" do
			KIT_PART_TYPES.each do |type|
				@checker.compat_conflicts(type).must_be_empty
			end
		end

		it "returns empty compatibility conflict lists for pairs" do
			@checker.pair_compat_conflicts.must_be_empty
		end

		it "returns empty works-badly conflict lists for each type" do
			KIT_PART_TYPES.each do |type|
				@checker.works_badly_conflicts(type).must_be_empty
			end
		end

		it "returns empty works-badly conflict lists for pairs" do
			@checker.pair_works_badly_conflicts.must_be_empty
		end
	end

	describe "incompatibilities exist" do
		before do
			t = Tank.create()
			w = Wick.create()
			t.set_compat_with(w, CompatPair::INCOMPATIBLE)

			kit = Kit.new
			kit.tank = t
			kit.wick = w

			@checker = ConfigChecker.new(kit)
		end

		it "returns non-empty compatibility conflict lists for the conflicting types" do
			@checker.compat_conflicts(:tank).length.must_equal 1
			@checker.compat_conflicts(:wick).length.must_equal 1
			@checker.compat_conflicts(:battery).must_be_empty
		end

		it "returns non-empty compatibility conflict lists for the conflicting pair" do
			@checker.pair_compat_conflicts.length.must_equal 1
		end

		# incompatibilities subsum works-badly conflicts
		it "returns empty works-badly lists" do
			@checker.works_badly_conflicts(:tank).must_be_empty
			@checker.works_badly_conflicts(:wick).must_be_empty
			@checker.works_badly_conflicts(:battery).must_be_empty
		end

		# incompatibilities subsum works-badly conflicts
		it "returns empty works-badly lists for pairs" do
			@checker.pair_works_badly_conflicts.must_be_empty
		end
	end
end