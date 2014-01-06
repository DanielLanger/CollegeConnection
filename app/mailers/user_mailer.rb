class MyMailer < ActionMailer::Base

  include SendGrid
  
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack

  def welcome_message(user)
    sendgrid_category "Welcome"
    mail :to => user.email, :subject => "Welcome #{user.name} :-)"
  end

  def goodbye_message(user)
    sendgrid_disable :ganalytics
    mail :to => user.email, :subject => "Fare thee well :-("
  end
end