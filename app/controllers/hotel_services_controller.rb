class HotelServicesController < ApplicationController
  soap_service namespace: "urn:hotel_ws", wsdl_style: "document"

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
    args: {add_new_constract_request: {
      hotelId: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingRooms: :integer,
      checkInDate: :string, checkOutDate: :string}},
    return: {result: :string}

  def add_new_constract
    params = get_constract_params

    constract = Constract.new standarlize_params params
    messages = constract.save ? I18n.t("action.success") : constract.errors.full_messages
    render soap: {result: messages}
  end

  soap_action "check_available_hotel",
    args: {hotelCode: :string},
    return: :boolean

  def check_available_hotel
    if params[:hotelCode].present?
      hotel = Hotel.find_by code: params[:hotelCode]
      render soap: hotel.present? && hotel.available_rooms > 0
    else
      render soap: I18n.t("errors.param_not_present", param: "hotelCode")
    end
  end

  soap_action "get_all_hotels",
    return: :string

  def get_all_hotels
    render soap: Hotel.all.to_json
  end

  private
  def standarlize_params params
    params.keys.each do |key|
      unless key.to_s == key.to_s.underscore
        params[key.to_s.underscore.to_sym] = params[key]
        params.delete key
      end
    end
    params
  end

  def get_constract_params
    check_in_date = params[:add_new_constract_request][:checkInDate].to_date
    check_out_date = params[:add_new_constract_request][:checkOutDate].to_s
    params[:add_new_constract_request][:checkInDate] = check_in_date
    params[:add_new_constract_request][:checkOutDate] = check_out_date
    params[:add_new_constract_request]
  end
end
