require "test_helper"

class ConfigCheckerTest < ActionView::TestCase

	def init(compat_relation)
		t = Tank.create()
		w = Wick.create()
		t.set_compat_with(w, compat_relation)

		my_config = MyConfig.new
		my_config.add_by_id(t.id)
		my_config.add_by_id(w.id)

		@checker = ConfigChecker.new(my_config)
	end

	describe "everything works well" do
		before do
			init(CompatPair::WORKS_WELL)
		end

		it "returns empty compatibility conflict lists for each type" do
			Kit::PART_TYPES.each do |type|
				@checker.compat_conflicts(type).must_be_empty
			end
		end

		it "returns empty compatibility conflict lists for pairs" do
			@checker.pair_compat_conflicts.must_be_empty
		end

		it "returns empty works-badly conflict lists for each type" do
			Kit::PART_TYPES.each do |type|
				@checker.works_badly_conflicts(type).must_be_empty
			end
		end

		it "returns empty works-badly conflict lists for pairs" do
			@checker.pair_works_badly_conflicts.must_be_empty
		end
	end

	describe "incompatibilities exist" do
		before do
			init(CompatPair::INCOMPATIBLE)
		end

		it "returns non-empty compatibility conflict lists for the conflicting types" do
			@checker.compat_conflicts(Product::TYPE_TANK).length.must_equal 1
			@checker.compat_conflicts(Product::TYPE_WICK).length.must_equal 1
			@checker.compat_conflicts(Product::TYPE_BATTERY).must_be_empty
		end

		it "returns non-empty compatibility conflict lists for the conflicting pair" do
			@checker.pair_compat_conflicts.length.must_equal 1
		end

		# incompatibilities subsum works-badly conflicts
		it "returns empty works-badly lists" do
			@checker.works_badly_conflicts(Product::TYPE_TANK).must_be_empty
			@checker.works_badly_conflicts(Product::TYPE_WICK).must_be_empty
			@checker.works_badly_conflicts(Product::TYPE_BATTERY).must_be_empty
		end

		# incompatibilities subsum works-badly conflicts
		it "returns empty works-badly lists for pairs" do
			@checker.pair_works_badly_conflicts.must_be_empty
		end
	end

	describe "more than two parts in MyConfig" do
		it "shows incompatibilities with three added parts" do
			m = Mouthpiece.create()
			t = Tank.create()
			w = Wick.create()

			m.set_compat_with(t, CompatPair::INCOMPATIBLE)
			t.set_compat_with(w, CompatPair::INCOMPATIBLE)

			my_config = MyConfig.new
			my_config.add_by_id(m.id)
			my_config.add_by_id(t.id)
			my_config.add_by_id(w.id)

			checker = ConfigChecker.new(my_config)

			checker.pair_compat_conflicts.length.must_equal 2
			checker.compat_conflicts(Product::TYPE_MOUTHPIECE).length.must_equal 1
			checker.compat_conflicts(Product::TYPE_TANK).length.must_equal 2
			checker.compat_conflicts(Product::TYPE_WICK).length.must_equal 1
		end
	end
end