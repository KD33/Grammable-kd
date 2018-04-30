require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    #set up a section describing how index action in grams controller behaves
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should successfully create a gram in our database" do
      post :create, params: { gram: { message: 'Hello!' }}
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("hello!")
    end
  end
end
