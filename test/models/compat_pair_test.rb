require "test_helper"

class CompatPairTest < ActiveSupport::TestCase

	describe "CompatPair" do
		before do
			@prod1 = Tank.create()
			@prod2 = Button.create() # is stored after prod1, has a higher id
		end

		it "stores if prod1.id < prod2.id" do
			cp = CompatPair.new(prod1: @prod1, prod2: @prod2)
			proc {cp.save!}.must_be_silent

			cp2 = CompatPair.find_by(prod1: cp.prod1, prod2: cp.prod2)
			cp2.prod1.must_equal @prod1
			cp2.prod2.must_equal @prod2
		end

		it "does not store if prod1.id > prod2.id" do
			cp = CompatPair.new(prod1: @prod2, prod2: @prod1)
			proc {cp.save!}.must_raise(ActiveRecord::RecordInvalid)
		end

		it "does not store if prod1 == prod2" do
			cp = CompatPair.new(prod1: @prod1, prod2: @prod1)
			proc {cp.save!}.must_raise(ActiveRecord::RecordInvalid)
		end

		it "does not store the same pair twice" do
			cp = CompatPair.create!(prod1: @prod1, prod2: @prod2)

			# try to store a new pair with the same two memebers
			cp = CompatPair.new(prod1: @prod1, prod2: @prod2)
			proc {cp.save!}.must_raise(ActiveRecord::RecordInvalid)
		end
	end

end
