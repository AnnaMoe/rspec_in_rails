require 'rails_helper'

RSpec.describe 'deleting an article' do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    #this method is provided by warden - need to include Warden in rails-helper
    login_as(@john)
    @article = Article.create(title: "First article", body: "Lorem ipsolum", user: @john) 
  end

  scenario 'user deletes an article' do
    visit '/'
    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end