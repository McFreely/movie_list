class ItemsController < ApplicationController
  attr_accessor :completed
  respond_to :html, :xml, :js
  
  def create 
    @item = current_user.items.new(params[:item])
    if @item.save
      redirect_to root_path
    else
      flash[:error] = "Could not add item to the list"
      redirect_to root_path
    end
  end
  
  def complete
    @item = current_user.items.find(params[:id])
    @item.completed = true
    @item.save
    redirect_to root_path
  end
  
  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
    redirect_to root_path
  end
end
