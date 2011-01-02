class RefineryFilebrowser < ActiveRecord::Base

  acts_as_indexed :fields => [:name]
  
  validate :name, :presence => true, :uniqueness => true


end
