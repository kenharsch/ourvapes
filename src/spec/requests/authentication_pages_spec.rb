require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "signin" do

		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_title('Sign in') }
			it { should have_selector('div.alert.alert-error') }
		end
		describe "with valid information" do
			let(:user) { User.create(name: "Ken H", email: "test@test.com", password: "qwerty", password_digest: "qwerty") }
			before do
				fill_in "Email",    with: user.email.downcase
				fill_in "Password", with: user.password
				click_button "Sign in"
			end
			
			subject { page }
			it { puts title}
			it { should have_title("VapeRater | " + user.name.to_s) }
			it { should have_link('Profile',     href: user_path(user)) }
			it { should have_link('Sign out',    href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }
		end
	end
end