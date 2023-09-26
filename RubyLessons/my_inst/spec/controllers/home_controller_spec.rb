require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    context 'when user is authenticated' do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in authenticated_user
      end

      it 'should redirect to posts_path' do
        get :index
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'when user is not authenticated' do
      it 'should not redirect' do
        get :index
        expect(response).not_to redirect_to(posts_path)
      end
    end
  end
end
