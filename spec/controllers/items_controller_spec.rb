require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe '#index' do
    it 'assigns @items' do
      item = create(:item, item_category: create(:item_category))
      get :index
      expect(assigns(:items)).to eq([item])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#create' do
    context 'when successful' do
      let(:item_category) { create(:item_category) }
      let(:item_params) do
        {
          item: attributes_for(:item).merge(item_category_id: item_category.id)
        }
      end

      it 'returns success response' do
        post :create, params: item_params, format: :html
        expect(response).to redirect_to(items_path)
        expect(flash[:secondary]).to eq('Item created successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when fields are not present' do
        let(:item_params) do
          {
            item: { name: nil, rate: nil, item_category_id: nil }
          }
        end

        it "returns error message as response" do
          post :create, params: item_params, format: :html
          expect(response).to redirect_to(items_path)
          expect(flash[:secondary]).to eq(
            "Name can't be blank, Rate can't be blank, and Item category must"\
            " exist"
          )
        end
      end
    end
  end

  describe '#update' do
    let(:item_category) { create(:item_category) }
    let(:item) { create(:item) }

    context 'when successful' do
      let(:item_params) do
        {
          id: item.id,
          item: attributes_for(:item).merge(item_category_id: item_category.id)
        }
      end

      it 'returns success response' do
        patch :update, params: item_params, format: :html
        expect(response).to redirect_to(items_path)
        expect(flash[:secondary]).to eq('Item updated successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when fields are not present' do
        let(:item_params) do
          { id: item.id, item: { name: nil, rate: nil, item_category_id: nil } }
        end

        it "returns error message as response" do
          patch :update, params: item_params, format: :html

          expect(response).to redirect_to(items_path)
          expect(flash[:secondary]).to eq(
            "Name can't be blank, Rate can't be blank, and Item category must"\
            " exist"
          )
        end
      end
    end
  end

  describe '#destroy' do
    let(:item) { create(:item) }

    context 'when successful' do
      let(:item_params) do
        { id: item.id }
      end

      it 'returns success response' do
        delete :destroy, params: item_params, format: :html
        expect(response).to redirect_to(items_path)
        expect(flash[:secondary]).to eq('Item deleted successfully')
      end
    end
  end
end
