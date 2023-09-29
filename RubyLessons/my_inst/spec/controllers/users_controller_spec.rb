require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  before { sign_in(user) }

  describe '#show' do
    let(:post) { create(:post, author: other_user) }

    it 'assigns the requested user as @user' do
      get :show, params: { id: other_user.id }
      expect(assigns(:user)).to eq(other_user)
    end

    it 'assigns the user posts ordered by created_at' do
      other_user.posts << post
      get :show, params: { id: other_user.id }
      expect(assigns(:posts)).to eq([post])
    end

    it 'sets reactions and comments' do
      get :show, params: { id: other_user.id }
      expect(assigns(:post_reactions)).to be_a(Hash)
      expect(assigns(:post_comments)).to be_a(Hash)
    end
  end

  describe '#profile' do
    let(:post) { create(:post, author: user) }

    it 'assigns the current user as @user' do
      get :profile
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the user posts ordered by created_at' do
      user.posts << post
      get :profile
      expect(assigns(:posts)).to eq([post])
    end

    it 'sets reactions and comments' do
      get :profile
      expect(assigns(:post_reactions)).to be_a(Hash)
      expect(assigns(:post_comments)).to be_a(Hash)
    end
  end

  describe '#subscribtions' do
    let(:subscriber) { create(:user) }
    let(:subscription) { create(:subscribtion, owner: user, subscriber: subscriber) }
    let(:post) { create(:post, author: user) }

    before { subscription }

    it 'assigns the current user as @user' do
      get :subscribtions
      expect(assigns(:user)).to eq(user)
    end

    it 'sets reactions and comments' do
      get :subscribtions
      expect(assigns(:post_reactions)).to be_a(Hash)
      expect(assigns(:post_comments)).to be_a(Hash)
    end
  end

  describe '#subscribe' do
    it 'creates a subscription and redirects with a notice on success' do
      expect {
        post :subscribe, params: { id: other_user.id }
      }.to change(Subscribtion, :count).by(1)

      expect(response).to redirect_to(user_path(other_user))
      expect(flash[:notice]).to eq('You are successfully subscribed')
    end

    it 'redirects with a notice on failure' do
      allow_any_instance_of(Subscribtion).to receive(:save).and_return(false)

      post :subscribe, params: { id: other_user.id }
      expect(response).to redirect_to(user_path(other_user))
      expect(flash[:notice]).to eq('Failed to subscribe')
    end
  end

  describe '#unsubscribe' do
    let(:subscription) { create(:subscribtion, owner: user, subscriber: other_user) }

    before { subscription }

    it 'destroys a subscription and redirects with a notice on success' do
      expect {
        delete :unsubscribe, params: { id: other_user.id }
      }.to change(Subscribtion, :count).by(-1)

      expect(response).to redirect_to(user_path(other_user))
      expect(flash[:notice]).to eq('You are successfully unsubscribed')
    end

    it 'redirects with a notice on failure' do
      allow_any_instance_of(Subscribtion).to receive(:destroyed?).and_return(false)

      delete :unsubscribe, params: { id: other_user.id }
      expect(response).to redirect_to(user_path(other_user))
      expect(flash[:notice]).to eq('Failed to unsubscribe')
    end
  end
end
