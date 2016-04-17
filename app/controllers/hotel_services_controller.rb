class HotelServicesController < ApplicationController
  soap_service namespace: "urn:hotel_ws", wsdl_style: "document"

  soap_action "check_available_hotel",
    args: {check_available_hotel_request: {hotelId: :integer, bookingRooms: :integer}},
    return: {result: :integer}

  def check_available_hotel
    hotel_params = params[:check_available_hotel_request] || {}
    hotel_params["bookingRooms"] ||= 1
    hotel_params["hotelId"] ||= 0

    condition = "id = #{hotel_params["hotelId"]} and available_rooms > #{hotel_params["bookingRooms"]}"
    hotels = Hotel.where condition
    render soap: {result: hotels.empty? ? 0 : 1}
  end

  soap_action "add_new_constract",
    args: {add_new_constract_request: {
      hotelId: :integer, customerIdNumber: :string,
      companyName: :string, companyPhone: :string,
      companyAddress: :string, bookingRooms: :integer,
      checkInDate: :string, checkOutDate: :string}},
    return: {result: :integer}

  def add_new_constract
    params = get_constract_params

    constract = Constract.new standarlize_params params
    messages = constract.save ? constract.id : -1
    render soap: {result: messages}
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
