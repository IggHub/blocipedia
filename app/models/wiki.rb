class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :user

  scope :visible_to_login, -> (user) { user.admin? || user.premium? ? all : where(private: [false, nil])}
  scope :visible_to_all, -> {where(private: [false, nil])}
#  delegate :users, to: :collaborators


end
