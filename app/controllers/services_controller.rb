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
