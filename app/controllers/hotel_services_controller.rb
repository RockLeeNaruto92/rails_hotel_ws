class HotelServicesController < ApplicationController
  soap_service namespace: "urn:hotel_ws", wsdl_style: "document"

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
    args: {check_available_hotel_request: {hotelCode: :string}},
    return: {result: :string}

  def check_available_hotel
    if params[:check_available_hotel_request] && params[:check_available_hotel_request][:hotelCode].present?
      hotel = Hotel.find_by code: params[:check_available_hotel_request][:hotelCode]
      render soap: {result: (hotel.present? && hotel.available_rooms > 0).to_s}
    else
      render soap: {result: I18n.t("errors.param_not_present", param: "hotelCode")}
    end
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
