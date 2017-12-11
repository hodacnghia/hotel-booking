require 'test_helper'

class MyHotelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_hotel_index_url
    assert_response :success
  end

end
