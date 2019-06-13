class ItemsController < ApplicationController
  before_action :set_category
  before_action :set_item, only: %i[edit update destroy]

  def index
    @item = @category.items.build
    @item.build_item_tax
    @items = @category.items.includes(:item_tax).order(:created_at)
                      .paginate(page: params[:page], per_page: 50)
  end

  def create
    @item = @category.items.create(item_params)
    message = if @item.persisted?
                'Item created successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_category_items_path(@category))
  end

  def edit; end

  def update
    message = if @item.update(item_params)
                'Item updated successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_category_items_path(@category))
  end

  def destroy
    message = if @item.destroy
                'Item deleted successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: item_category_items_path(@category))
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :item_category_id, :rate, item_tax_attributes: %i[id tax tax_type]
    )
  end

  def set_category
    @category = ItemCategory.find(params[:item_category_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
