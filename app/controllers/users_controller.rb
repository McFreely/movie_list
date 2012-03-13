class UsersController < ApplicationController
  
  def new
  end
  
  def show 
    @items = current_user.items.all
    @item = current_user.items.new
  end
end