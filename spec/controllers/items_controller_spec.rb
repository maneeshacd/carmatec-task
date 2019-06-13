require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe '#index' do
    let(:item_category) { create(:item_category) }

    it 'assigns @items' do
      item = create(:item, item_category: item_category)
      get :index, params: { item_category_id: item_category.id }, format: :html
      expect(assigns(:items)).to eq([item])
    end

    it 'renders the index template' do
      get :index, params: { item_category_id: item_category.id }, format: :html
      expect(response).to render_template('index')
    end
  end

  describe '#create' do
    context 'when successful' do
      let(:item_category) { create(:item_category) }
      let(:item_tax) { attributes_for(:item_tax) }
      let(:item_params) do
        {
          item_category_id: item_category.id,
          item: attributes_for(:item).merge(
            item_category_id: item_category.id,
            item_tax_attributes: item_tax
          )
        }
      end

      it 'returns success response' do
        post :create, params: item_params, format: :html
        expect(response).to redirect_to(
          item_category_items_path(item_category)
        )
        expect(flash[:secondary]).to eq('Item created successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when fields are not present' do
        let(:item_category) { create(:item_category) }
        let(:item_params) do
          {
            item_category_id: item_category.id,
            item: { name: nil, rate: nil }
          }
        end

        it 'returns error message as response' do
          post :create, params: item_params, format: :html
          expect(response).to redirect_to(
            item_category_items_path(item_category)
          )
          expect(flash[:secondary]).to eq(
            "Name can't be blank and Rate can't be blank"
          )
        end
      end
    end
  end

  describe '#update' do
    let(:item_category) { create(:item_category) }
    let(:item_tax) { attributes_for(:item_tax) }
    let(:item) { create(:item) }

    context 'when successful' do
      let(:item_params) do
        {
          id: item.id,
          item_category_id: item_category.id,
          item: attributes_for(:item).merge(
            item_tax_attributes: item_tax
          )
        }
      end

      it 'returns success response' do
        patch :update, params: item_params, format: :html
        expect(response).to redirect_to(
          item_category_items_path(item_category)
        )
        expect(flash[:secondary]).to eq('Item updated successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when fields are not present' do
        let(:item_params) do
          {
            id: item.id,
            item_category_id: item_category.id,
            item: { name: nil, rate: nil }
          }
        end

        it 'returns error message as response' do
          patch :update, params: item_params, format: :html

          expect(response).to redirect_to(
            item_category_items_path(item_category)
          )
          expect(flash[:secondary]).to eq(
            "Name can't be blank and Rate can't be blank"
          )
        end
      end
    end
  end

  describe '#destroy' do
    let(:item) { create(:item) }
    let(:item_category) { create(:item_category) }

    context 'when successful' do
      let(:item_params) do
        { id: item.id, item_category_id: item_category.id, }
      end

      it 'returns success response' do
        delete :destroy, params: item_params, format: :html
        expect(response).to redirect_to(
          item_category_items_path(item_category)
        )
        expect(flash[:secondary]).to eq('Item deleted successfully')
      end
    end
  end
end
