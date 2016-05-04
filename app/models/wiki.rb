class Wiki < ActiveRecord::Base
  belongs_to :user
  scope :visible_to_login, -> (user) { user.admin? || user.premium? ? all : where(private: [false, nil])}
  scope :visible_to_all, -> {where(private: [false, nil])}
end
