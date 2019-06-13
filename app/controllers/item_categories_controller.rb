class ItemCategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]
  def index
    @item_categories = ItemCategory.includes(:items).order(:created_at)
                                   .paginate(page: params[:page], per_page: 50)
  end

  def create
    @category = ItemCategory.create(category_params)
    message = if @category.persisted?
                'Category created successfully'
              else
                @category.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_categories_path)
  end

  def edit; end

  def update
    message = if @category.update(category_params)
                'Category updated successfully'
              else
                @category.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_categories_path)
  end

  def destroy
    message = if @category.destroy
                'Category deleted successfully'
              else
                @category.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_categories_path)
  end

  private

  def set_category
    @category = ItemCategory.find(params[:id])
  end

  def category_params
    params.require(:item_category).permit(:name)
  end
end
