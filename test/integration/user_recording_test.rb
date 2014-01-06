require 'test_helper'

class UserRecordingTest < ActionDispatch::IntegrationTest
  javascript
  
  setup do
    User.create(email: 'dlanger99@gmail.com', password: 'test123' , password_confirmation: 'test123' )
    
    visit new_user_session_path
    fill_in 'Email', with: 'dlanger99@gmail.com'
    fill_in 'Password', with: 'test123'
    click_button 'Sign in'
  end
end
