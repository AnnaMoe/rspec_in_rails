require 'rails_helper'
RSpec.describe "Comments", type: :request do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "Title one", body: "Body of article one", user: @john)
  end

  describe 'POST /articles/:id/comments' do 
    context "with non-signed-in user" do
      before do
       post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome blog"} }
      end
      it "redirects to the signin page" do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context "with a logged-in user" do
      before do
        login_as(@john)
        post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog"}}
      end
      it "let the user create a comment" do
        expect(response.status).to eq 200
        expect(response).to redirect_to(articles_path(@article))
        flash_message = "Comment has been created."
        expect(flash[:notice]).to eq flash_message
      end
    end 
  end
end