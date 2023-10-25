require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }
  let(:valid_attributes) { attributes_for(:group) }
  let(:invalid_attributes) { { name: '', icon: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all groups of the current user to @groups' do
      group
      get :index
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe 'GET #new' do
    it 'assigns a new group to @group' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Group for the current user' do
        expect do
          post :create, params: { group: valid_attributes }
        end.to change(user.groups, :count).by(1)
      end

      it 'redirects to the groups index' do
        post :create, params: { group: valid_attributes }
        expect(response).to redirect_to(groups_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Group' do
        expect do
          post :create, params: { group: invalid_attributes }
        end.not_to change(Group, :count)
      end

      it 'renders the :new template' do
        post :create, params: { group: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
