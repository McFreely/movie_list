class ItemsController < ApplicationController
  attr_accessor :completed
  respond_to :html, :xml, :json

  def show
    @items = current_user.items.all
    @item = current_user.items.new
  end

  def create
    @item = current_user.items.new(params[:item])
    @item.save

    respond_to do |format|
     format.html { render :partial => "items"}
      format.js
    end
  end

  def complete
    @item = current_user.items.find(params[:id])
    @item.completed = true
    @item.save

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.js
    end

  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.js
    end
  end
end
