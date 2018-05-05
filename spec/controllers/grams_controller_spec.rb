require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#show action" do
    it "should successfully show the page if the gram is found" do
      gram = FactoryBot.create(:gram)
      get :show, params: {id: gram.id}
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the gram is not found" do
      get :show, params: {id: 'TACOCAT'}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#index action" do
    #set up a section describing how index action in grams controller behaves
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should requrie users to be logged in" do
      post :create, params: {grams: {message: "Hello"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a gram in our database" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { gram: { message: 'hello!' }}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("hello!")
      expect(gram.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user
      gram_count = Gram.count
      post :create, params: {gram: {message: ''}}
      expect(response).to have_http_status(:unprocessable_entity)
      #make sure the gram hasn't been saved in db
      expect(gram_count).to eq Gram.count
    end
  end
end
