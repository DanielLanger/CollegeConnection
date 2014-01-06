require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Should not save user without name" do
    user= User.new
    assert !user.save
  end
end
