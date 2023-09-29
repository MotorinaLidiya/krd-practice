require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when user is not logged in' do
      it 'redirects to the landing page' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }

      it 'renders the index template' do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template('index')
      end
    end
  end

  describe '#new' do
    context 'when user is not logged in' do
      it 'redirects to the landing page' do
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }

      it 'renders the new template' do
        get :new
        expect(response).to render_template('new')
      end
    end
  end

  describe '#create' do
    context 'when user is not logged in' do
      it 'redirects to the landing page' do
        post :create, params: { post: { title: 'New Post' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }

      it 'creates a new post' do
        expect {
          post :create, params: { post: { title: 'New Post' } }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to posts_path on successful creation' do
        post :create, params: { post: { title: 'New Post' } }
        expect(response).to redirect_to(profile_path)
        expect(flash[:notice]).to eq('Post was successfully created')
      end

      it 'renders the new template on failed creation' do
        post :create, params: { post: { title: '' } }
        expect(response).to render_template('new')
      end
    end
  end

  describe '#edit' do
    let(:valid_attributes) { { title: 'Test Post' } }
    let(:invalid_attributes) { { title: nil } }
    let(:post) { create(:post, author: user) }

    before { sign_in(user) }
  
    it 'assigns the requested post as @post' do
      get :edit, params: { id: post.to_param }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe '#update' do
    let(:valid_attributes) { { title: 'Test Post' } }
    let(:invalid_attributes) { { title: nil } }
    let(:post) { create(:post, author: user) }

    before { sign_in(user) }

    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Post' } }

      it 'updates the requested post' do
        put :update, params: { id: post.to_param, post: new_attributes }
        post.reload
        expect(post.title).to eq('Updated Post')
      end

      it 'redirects to the profile_path' do
        put :update, params: { id: post.to_param, post: new_attributes }
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'with invalid params' do
      it 'does not update the post' do
        put :update, params: { id: post.to_param, post: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    let(:valid_attributes) { { title: 'Test Post' } }
    let(:invalid_attributes) { { title: nil } }
    let(:post) { create(:post, author: user) }
    
    before { sign_in(user) }

    it 'destroys the requested post' do
      post # Create a post
      expect {
        delete :destroy, params: { id: post.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the profile_path' do
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(profile_path)
    end
  end
end
