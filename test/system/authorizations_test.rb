require "application_system_test_case"

class AuthorizationsTest < ApplicationSystemTestCase


  Prefix                     
-----------------------------------------------
  rails_mailers                               |
  rails_info_properties                       |
  rails_info_routes                           |
  rails_info                                  |
  reviews_search_reviews                      |
  reviews                                     |
  new_review                                  |
  edit_review                                 |
  review                                      |
  movies                                      |
  new_movie                                   |
  edit_movie                                  |
  movie                                       |
  new_user_session                            |
  user_session                                |
  destroy_user_session                        |
  new_user_password                           |
  edit_user_password                          |
  user_password                               |
  cancel_user_registration                    |
  new_user_registration                       |
  edit_user_registration                      |
  user_registration                           |
  root                                        |
  account                                     |
  email_sent                                  |
  edit_account                                |
  edit_password                               |
  turbo_recede_historical_location            |
  turbo_resume_historical_location            |
  turbo_refresh_historical_location           |
  rails_postmark_inbound_emails               |
  rails_relay_inbound_emails                  |
  rails_sendgrid_inbound_emails               |
  rails_mandrill_inbound_health_check         |
  rails_mandrill_inbound_emails               |
  rails_mailgun_inbound_emails                |
  rails_conductor_inbound_emails              |
  new_rails_conductor_inbound_email           |
  edit_rails_conductor_inbound_email          | 
  rails_conductor_inbound_email               | 
  new_rails_conductor_inbound_email_source    | 
  rails_conductor_inbound_email_sources       | 
  rails_conductor_inbound_email_reroute       | 
  rails_conductor_inbound_email_incinerate    | 
  rails_service_blob                          | 
  rails_service_blob_proxy                    | 
  rails_blob_representation                   | 
  rails_blob_representation_proxy             |
  rails_disk_service                          |
  update_rails_disk_service                   |
  rails_direct_uploads                        



  test "deny user access to movies/reviews/new" do
    login_as_user
    visit "/movies/reviews/new"
    assert_equal movies_path, current_path
    assert_text "Sorry you dont have the proper permissions to perform this action"
   end

   test "deny user access to movies/reviews/search" do
    login_as_user
    visit "/movies/reviews/search"
    assert_equal movies_path, current_path
    assert_text "Sorry you dont have the proper permissions to perform this action"
   end

   test ""

end
