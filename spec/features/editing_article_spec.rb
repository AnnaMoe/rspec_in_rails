require 'rails_helper'

RSpec.describe 'editing an article' do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    #this method is provided by warden - need to include Warden in rails-helper
    login_as(@john)
    @article = Article.create(title: "First article", body: "Lorem ipsolum", user: @john) 
  end

  scenario 'a user updates an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit Article'
    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body"
    click_button "Update Article"

    expect(Article.last.user).to eq(@john)
    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'a user fails to update an article' do
    visit '/'
    click_link @article.title
    click_link 'Edit Article'
    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

end