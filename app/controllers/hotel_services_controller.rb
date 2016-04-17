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
end
