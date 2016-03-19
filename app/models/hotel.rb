class Hotel < ActiveRecord::Base
  before_create :initialize_available_rooms

  has_many :constracts

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :star, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :city, presence: true
  validates :country, presence: true
  validates :address, presence: true
  validates :website, presence: true
  validates :total_rooms, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :cost, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}

  private
  def initialize_available_rooms
    self.available_rooms = total_rooms
  end
end
