require 'rails_helper'

RSpec.describe 'show an article' do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    #this method is provided by warden - need to include Warden in rails-helper
    #login_as(@john)
    @article = Article.create(title: "First article", body: "Lorem ipsolum", user: @john) 
  end

  scenario 'to non signed-in users hide edit and delete button' do
    visit '/'
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'to non-owner hide edit and delete button' do
    login_as(@fred)
    visit '/'
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

   scenario 'to owners of edit and delete button' do
    login_as(@john) 
    visit '/'
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
  
end