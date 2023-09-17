require 'rails_helper'

RSpec.describe LabsController, type: :controller do
  let(:user) { create(:user) }
  let(:lab) { create(:lab, user: user) }

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
      before { sign_in user }
      
      it 'should return 200', :aggregate_failures do
        subject
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end

  describe '#create' do
    before { sign_in user }

    context 'with valid parameters' do
      it 'creates a new lab' do
        expect { 
          post :create, params: { lab: { title: 'test', description: 'des', user_id: user.id } }
        }.to change(Lab, :count).by(1)
      end

      it 'redirects to the labs' do
        post :create, params: { lab: { title: 'test', description: 'des', user_id: user.id } }
        expect(response).to redirect_to(labs_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new lab' do
        expect {
          post :create, params: { lab: { title: '', description: '', user_id: user.id } }
        }.not_to change(Lab, :count)
      end

      it 'renders the new template' do
        post :create, params: { lab: { title: '', description: '', user_id: user.id } }
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe '#destroy' do
    before { sign_in user }

    it 'destroys a lab' do
      lab
      expect {
        delete :destroy, params: { id: lab.id }
      }.to change(Lab, :count).by(-1)

      expect(response).to have_http_status(:success)
      expect(response.body).to include("lab_#{lab.id}")

      expect(flash[:notice]).to eq("Lab with title #{lab.title} deleted")
    end
  end

  describe '#grade' do
    before { sign_in user }
    
    it 'renders the grade template' do
      get :grade, params: { id: lab.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:grade)
    end
  end

  describe '#mark' do
    before { sign_in user }
    
    it 'updates the lab and redirects to labs path' do
      patch :mark, params: { id: lab.id, lab: { grade: 'a' } }
      lab.reload
      expect(lab.grade).to eq('a')
      expect(response).to redirect_to(labs_path)
      expect(flash[:notice]).to eq('Lab was graded')
    end

    it 'renders the grade template if the update fails' do
      patch :mark, params: { id: lab.id, lab: { grade: 'Invalid Grade' } }
      lab.reload
      expect(lab.grade).not_to eq('Invalid Grade')
      expect(response).to render_template(:grade)
    end
  end
end
