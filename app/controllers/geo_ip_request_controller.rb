class GeoIpRequestController < ApplicationController
  def new

  end

  def create
    require 'geoip'
    @info = GeoIP.new(Rails.root.join("GeoLiteCity.dat")).city(ip_request_params[:host])
  end

private
  def ip_request_params
    params.require(:request).permit(:host)
  end
end
