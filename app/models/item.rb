class Item < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 75 }
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
  default_scope :order => 'items.created_at DESC'
  
end
