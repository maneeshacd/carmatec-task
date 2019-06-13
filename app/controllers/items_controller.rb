class ItemsController < ApplicationController
  before_action :set_item, only: %i[edit update destroy]

  def index
    @items = Item.order(:created_at)
  end

  def create
    @item = Item.create(item_params)
    message = if @item.persisted?
                'Item created successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: items_path)
  end

  def edit; end

  def update
    message = if @item.update(item_params)
                'Item updated successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: items_path)
  end

  def destroy
    message = if @item.destroy
                'Item deleted successfully'
              else
                @item.errors.full_messages.to_sentence
              end
    flash[:secondary] = message
    redirect_back(fallback_location: items_path)
  end

  private

  def item_params
    params.require(:item).permit(:name, :item_category_id, :rate)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
