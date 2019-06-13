require 'rails_helper'

RSpec.describe ItemCategoriesController, type: :controller do
  describe '#index' do
    it 'assigns @categories' do
      item_category = ItemCategory.create(name: 'Electronics')
      get :index
      expect(assigns(:item_categories)).to eq([item_category])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#create' do
    context 'when successful' do
      let(:item_category) { build(:item_category) }
      let(:category_params) do
        {
          item_category: { name: item_category.name }
        }
      end

      it 'returns success response' do
        post :create, params: category_params, format: :html
        expect(response).to redirect_to(item_categories_path)
        expect(flash[:secondary]).to eq('Category created successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when name is not present' do
        let(:category_params) do
          {
            item_category: { name: nil }
          }
        end

        it "returns name can't be blank error as response" do
          post :create, params: category_params, format: :html
          expect(response).to redirect_to(item_categories_path)
          expect(flash[:secondary]).to eq("Name can't be blank")
        end
      end
    end
  end

  describe '#update' do
    let(:item_category) { create(:item_category) }

    context 'when successful' do
      let(:category_params) do
        { id: item_category.id, item_category: { name: 'Electronics' } }
      end

      it 'returns success response' do
        patch :update, params: category_params, format: :html
        expect(response).to redirect_to(item_categories_path)
        expect(flash[:secondary]).to eq('Category updated successfully')
      end
    end

    context 'when unsuccessful' do
      context 'when name is not present' do
        let(:category_params) do
          { id: item_category.id, item_category: { name: nil } }
        end

        it "returns name can't be blank error as response" do
          patch :update, params: category_params, format: :html

          expect(response).to redirect_to(item_categories_path)
          expect(flash[:secondary]).to eq("Name can't be blank")
        end
      end
    end
  end

  describe '#destroy' do
    let(:item_category) { create(:item_category) }

    context 'when successful' do
      let(:category_params) do
        { id: item_category.id }
      end

      it 'returns success response' do
        delete :destroy, params: category_params, format: :html
        expect(response).to redirect_to(item_categories_path)
        expect(flash[:secondary]).to eq('Category deleted successfully')
      end
    end
  end

  describe '#categories_with_items' do
    it 'assigns @item_categories' do
      item_category = ItemCategory.create(name: 'Electronics')
      get :categories_with_items
      expect(assigns(:item_categories)).to eq([item_category])
    end
  end
end
