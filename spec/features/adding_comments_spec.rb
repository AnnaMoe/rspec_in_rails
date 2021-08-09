require 'rails_helper'

RSpec.describe "Adding reviews to Articles" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
      #this method is provided by warden - need to include Warden in rails-helper
    @article = Article.create(title: "First article", body: "Lorem ipsolum", user: @john)  
  end

  scenario "a user adds a comment to an article" do
    login_as(@fred)
    visit '/'
    click_link @article.title
    fill_in "New Comment", with: "Amazing Article"
    click_button "Add Comment"  

    expect(page).to have_content("Comment has been created.")
    expect(page).to have_content("Amazing Article")
    expect(current_path).to eq(article_path(@article))
  end
end