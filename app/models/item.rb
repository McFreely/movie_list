class Item < ActiveRecord::Base
  
  validates :title, :presence => true
  
  belongs_to :user
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
end
