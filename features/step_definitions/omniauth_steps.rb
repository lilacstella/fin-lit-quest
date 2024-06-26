# frozen_string_literal: true

Given('I am not logged in') do
  visit logout_path
  visit root_path
  expect(page).to have_current_path welcome_path
end

Given('I am logged in as {string}') do |name|
  OmniAuth.config.test_mode = true
  player = Player.find_by(name:)
  Capybara.default_host = 'https://fin-lit-quest-65cfa09cddc8.herokuapp.com/'

  OmniAuth.config.add_mock(:google_oauth2, {
                             uid: player.uid,
                             info: {
                               name: player.name,
                               email: player.email
                             }
                           })

  visit welcome_path
  click_on 'Sign in with Google'
  visit test_login_path
  expect(page).to have_content('true')
  OmniAuth.config.test_mode = false
end
