class Knok < ApplicationRecord

  belongs_to :from, :class_name=>'User', :foreign_key=>'from_id'
  belongs_to :to, :class_name=>'User', :foreign_key=>'to_id'
  
  validates_uniqueness_of :from_id, scope: :to_id
  validates_uniqueness_of :to_id, scope: :from_id


end
