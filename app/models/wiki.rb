class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :wiki_collaborators

  has_many :collaborators, through: :wiki_collaborators, dependent: :destroy, class_name: 'User'


  scope :visible_to_login, -> (user) { user.admin? || user.premium? ? all : where(private: [false, nil])}
  scope :visible_to_all, -> {where(private: [false, nil])}
#  delegate :users, to: :collaborators

  def collaborators
    Collaborator.where(wiki_id: id)
  end

end
