require 'test_helper'

class Api::PushesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Push.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Push.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Push.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to api_push_url(assigns(:push))
  end

  def test_edit
    get :edit, :id => Push.first
    assert_template 'edit'
  end

  def test_update_invalid
    Push.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Push.first
    assert_template 'edit'
  end

  def test_update_valid
    Push.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Push.first
    assert_redirected_to api_push_url(assigns(:push))
  end

  def test_destroy
    push = Push.first
    delete :destroy, :id => push
    assert_redirected_to api_pushes_url
    assert !Push.exists?(push.id)
  end
end
