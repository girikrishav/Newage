class Role < ActiveRecord::Base
  has_many :admin_users

  attr_accessible :name, :rank

  validates :name, presence: :true
  validates :rank, presence: :true
end
