class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators


  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role #after_initialize callback is triggered for each object that is found and instantiated by a finder, with after_initialize being triggered after new objects are instantiated as well.


  private

  def set_default_role
    self.role ||= :standard
  end


end
