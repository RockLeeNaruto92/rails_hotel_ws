class Constract < ActiveRecord::Base
  before_save :initialize_total_money, :decrease_hotel_available_rooms

  belongs_to :hotel

  validates :hotel, presence: true
  validates :customer_id_number, presence: true
  validates :company_name, presence: true
  validates :company_phone, presence: true
  validates :company_address, presence: true
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true

  validate :in_out_date_validation
  validate :booking_rooms_validation

  private
  def in_out_date_validation
    return unless check_in_date.present? && check_out_date.present?

    if check_in_date > check_out_date
      errors.add :check_in_date,
        message: I18n.t("errors.less_than_attr", attr: "check_out_date")
    end
  end

  def booking_rooms_validation
    return unless hotel.present?
    case
    when !booking_rooms.is_a?(Integer)
      errors.add :booking_rooms, message: I18n.t("errors.not_integer")
    when booking_rooms < 1
      errors.add :booking_rooms,
        message: I18n.t("errors.greater_than", number: 0)
    when booking_rooms > self.hotel.available_rooms
      errors.add :booking_rooms,
        message: I18n.t("errors.less_than_attr", attr: "available_rooms")
    end
  end

  def initialize_total_money
    self.total_money = hotel.cost * booking_rooms
  end

  def decrease_hotel_available_rooms
    self.hotel.update! available_rooms: (hotel.available_rooms - booking_rooms)
  end
end
