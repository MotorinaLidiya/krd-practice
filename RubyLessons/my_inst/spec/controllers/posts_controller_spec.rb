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

  describe '#profile' do
    context 'when user is not logged in' do
      it 'redirects to the landing page' do
        get :profile
        expect(response).to have_http_status(:redirect)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      before { sign_in user }

      it 'renders the profile template' do
        get :profile
        expect(response).to render_template('profile')
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
        expect(response).to redirect_to(posts_path)
        expect(flash[:notice]).to eq('Post was successfully created')
      end

      it 'renders the new template on failed creation' do
        post :create, params: { post: { title: '' } }
        expect(response).to render_template('new')
      end
    end
  end
end
