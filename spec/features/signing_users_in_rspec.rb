require 'rails_helper'

RSpec.describe "Users signin" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"

    expect(page).to have_content("Signed in sucessfully.")
    expect(page).to have_content("Signed in as #{@john.email}.")
    expect(page).not_to link("Sign in")
    expect(page).not_to link("Sign up")
  end

end 