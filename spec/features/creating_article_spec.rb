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
  # scenatio = describe
  scenario 'user creates a new article' do
    visit '/'
    click_link 'New Article'
    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Article"
  
    expect(page).to have_content("Article has been created.")
    expect(page.current_path).to eq(articles_path)
  end
  
end