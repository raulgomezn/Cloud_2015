require 'test_helper'

class CompetitorsControllerTest < ActionController::TestCase
  setup do
    @competitor = competitors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competitors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competitor" do
    assert_difference('Competitor.count') do
      post :create, competitor: { competition_id: @competitor.competition_id, date_admission: @competitor.date_admission, email: @competitor.email, first_name: @competitor.first_name, last_name: @competitor.last_name, message: @competitor.message, second_last_name: @competitor.second_last_name, second_name: @competitor.second_name, status_video: @competitor.status_video, url_video_converted: @competitor.url_video_converted, url_video_original: @competitor.url_video_original }
    end

    assert_redirected_to competitor_path(assigns(:competitor))
  end

  test "should show competitor" do
    get :show, id: @competitor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @competitor
    assert_response :success
  end

  test "should update competitor" do
    patch :update, id: @competitor, competitor: { competition_id: @competitor.competition_id, date_admission: @competitor.date_admission, email: @competitor.email, first_name: @competitor.first_name, last_name: @competitor.last_name, message: @competitor.message, second_last_name: @competitor.second_last_name, second_name: @competitor.second_name, status_video: @competitor.status_video, url_video_converted: @competitor.url_video_converted, url_video_original: @competitor.url_video_original }
    assert_redirected_to competitor_path(assigns(:competitor))
  end

  test "should destroy competitor" do
    assert_difference('Competitor.count', -1) do
      delete :destroy, id: @competitor
    end

    assert_redirected_to competitors_path
  end
end
