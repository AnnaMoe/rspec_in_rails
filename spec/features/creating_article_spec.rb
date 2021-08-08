require 'rails_helper'

# https://devhints.io/capybara

# Visit root page
# click on new article
# fill in title
# fill in body
# create article

# expectations:
# article has been created
# articles path

#feature = describe
RSpec.describe 'creating articles' do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    #this method is provided by warden - need to include Warden in rails-helper
    login_as(@john)
  end
  scenario 'user creates a new article' do
    visit '/'
    click_link 'New Article'
    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"
  
    expect(Article.last.user).to eq(@john)
    expect(page).to have_content("Article has been created.")
    expect(page).to have_content("Created by: #{@john.email}")
    expect(page.current_path).to eq(articles_path)
  end

  scenario 'A user fails to create a new article' do
    visit '/'
    click_link 'New Article'
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"

    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
    
  end
  
end