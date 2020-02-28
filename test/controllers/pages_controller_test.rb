require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get changelog" do
    get changelog_url
    assert_response :success
    assert_select "h1", text: "Changelog"
  end
end
