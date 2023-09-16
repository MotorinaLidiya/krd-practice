require 'rails_helper'

RSpec.describe LabsController, type: :controller do
  describe '#index' do
    subject { get :index }
    
    context 'when user is not logged in' do
      it 'should redirect to sign in form' do
        subject
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }

      before { sign_in user }
      
      it 'should return 200', :aggregate_failures do
        subject
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end
end