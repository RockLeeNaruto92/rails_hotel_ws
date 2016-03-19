class ServicesController < ApplicationController
  soap_service namespace: "urn:hotel_ws"

  soap_action "add_new_hotel",
    args: {code: :string, name: :string, star: :integer,
      city: :string, country: :string, address: :string,
      website: :string, phone: :string, totalRooms: :integer,
      cost: :integer},
    return: :string

  def add_new_hotel
    standarlize_params
    hotel = Hotel.new params
    messages = hotel.save ? I18n.t("action.success") : hotel.errors.full_messages
    render soap: messages
  end

  soap_action "is_existed_hotel",
    args: {code: :string, name: :string},
    return: :boolean

  def is_existed_hotel
    hotel = Hotel.find_by code: params[:code] if params[:code].present?
    if !hotel.present? && params[:name].present?
      hotel = Hotel.find_by name: params[:name] unless hotel.present?
    end
    render soap: hotel.present?
  end

  soap_action "find_hotels_by_city",
    args: {cityName: :string},
    return: :string

  def find_hotels_by_city
    if params[:cityName].present?
      render soap: Hotel.where(city: params[:cityName]).to_json
    else
      render soap: I18n.t("errors.param_not_present", param: "cityName")
    end
  end

  soap_action "add_new_constract",
    args: {hotelID: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingRooms: :integer,
      checkInDate: :date, checkOutDate: :date},
    return: :string

  def add_new_constract
    standarlize_params
    constract = Constract.new params
    messages = constract.save ? I18n.t("action.success") : constract.errors.full_messages
    render soap: messages
  end

  private
  def standarlize_params
    params.keys.each do |key|
      unless key.to_s == key.to_s.underscore
        params[key.to_s.underscore.to_sym] = params[key]
        params.delete key
      end
    end
  end
end
