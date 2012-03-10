class UsersController < ApplicationController
  
  def new
  end
  
  def show 
    @item = current_user.items.new
  end
  
end