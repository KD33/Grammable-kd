require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'comments#create action' do
    it 'should allow users to create comments on grams' do
      gram = FactoryBot.create(:gram)
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {gram_id: gram.id, comment: { message: 'awesome gram' } }

      expect(response).to redirect_to root_path
      expect(gram.comments.length).to eq 1
      expect(gram.comments.first.message).to eq "awesome gram"
    end

    it 'should require a user to be logged in to comment on a gram' do
      gram = FactoryBot.create(:gram)
      post :create, params: {gram_id: gram.id, comment: {message: 'awesome gram'} }
      expect(response).to redirect_to new_user_session_path
    end

    it 'should return http status code of not found it he gram isn\'t found' do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {gram_id: 'YOLOSWAG', comment: {message: 'awesome gram'} }
      expect(response).to have_http_status :not_found
    end
  end
end
