require 'rails_helper'

RSpec.describe 'show an article' do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    #this method is provided by warden - need to include Warden in rails-helper
    login_as(@john)
    @article = Article.create(title: "First article", body: "Lorem ipsolum", user: @john) 
  end

  it 'a user can see the details of one article' do
    visit '/'
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end