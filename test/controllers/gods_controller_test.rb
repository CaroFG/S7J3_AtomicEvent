require 'test_helper'

class GodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gods_index_url
    assert_response :success
  end

end
