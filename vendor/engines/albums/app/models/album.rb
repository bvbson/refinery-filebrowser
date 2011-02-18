class Album < ActiveRecord::Base

  acts_as_indexed :fields => [:name, :cover]
  
  validates_presence_of :name
  validates_uniqueness_of :name
  


end
