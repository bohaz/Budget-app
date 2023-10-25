require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }
  let(:operation) { create(:operation, author: user, group:) }
  let(:valid_attributes) { attributes_for(:operation).merge(author_id: user.id) }
  let(:invalid_attributes) { { name: '', amount: nil } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns the specified group to @group' do
      get :index, params: { group_id: group.id }
      expect(assigns(:group)).to eq(group)
    end

    it 'assigns the current user operations for the specified group to @operations' do
      operation
      get :index, params: { group_id: group.id }
      expect(assigns(:operations)).to eq([operation])
    end

    it 'assigns groups with operations by the current user to @groups' do
      operation
      get :index, params: { group_id: group.id }
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe 'GET #new' do
    it 'assigns a new operation to @operation for the specified group' do
      get :new, params: { group_id: group.id }
      expect(assigns(:operation)).to be_a_new(Operation)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Operation for the specified group and current user as the author' do
        expect do
          post :create, params: { group_id: group.id, operation: valid_attributes }
        end.to change(Operation, :count).by(1)
      end

      it 'redirects to the operations index for the group' do
        post :create, params: { group_id: group.id, operation: valid_attributes }
        expect(response).to redirect_to(group_operations_path(group))
      end
    end

    context 'with invalid params' do
      it 'does not create a new Operation' do
        expect do
          post :create, params: { group_id: group.id, operation: invalid_attributes }
        end.not_to change(Operation, :count)
      end

      it 'renders the :new template' do
        post :create, params: { group_id: group.id, operation: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
