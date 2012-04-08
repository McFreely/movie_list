class Item < ActiveRecord::Base
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 75}
  validates :categorie, :presence => true
  
  scope :completed, where(:completed => true)
  scope :incomplete, where(:completed => false)
  
  default_scope :order => 'items.updated_at DESC'
  
end
