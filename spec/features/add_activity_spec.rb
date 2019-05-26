# frozen_string_literal: true

require 'rails_helper'

feature 'AddActivity' do
  include Devise::Test::IntegrationHelpers
  scenario 'Adding an activity as logged in user' do
    given_i_am_logged_in
    when_i_visit_root_path
    and_i_add_activity
    then_i_am_redirected_to_activity
    and_it_shows_me_last_distance_and_weekly_distance
    and_the_activity_should_appear_in_my_statistics
  end

  scenario 'Adding an activity as not logged in user' do
    when_i_visit_root_path
    then_i_am_redirected_to_sign_in
  end

  def given_i_am_logged_in
    @user = FactoryBot.create(:user)
    login_as @user
  end

  def when_i_visit_root_path
    visit root_path
  end

  def and_i_add_activity
    fill_in 'activity[start_point]', with: 'Plac Europejski 2, Warszawa, Polska'
    fill_in 'activity[end_point]', with: 'Andersa 2, Warszawa, Polska'
    click_button 'Create Activity'
  end

  def then_i_am_redirected_to_activity
    expect(page.current_path).to eq activity_path(@user.activities.last)
  end

  def and_it_shows_me_last_distance_and_weekly_distance
    expect(page).to have_content('Your last distance is: 2.75 km')
    expect(page).to have_content('This week you fitofitted: 2.75 km')
  end

  def and_the_activity_should_appear_in_my_statistics
    click_button 'Show statistics'
    expect(page.current_path).to eq statistics_path
    today_date = Date.today.strftime('%d. %B')
    expect(page).to have_content(today_date)
    expect(page).to have_content('2.75 km')
  end

  def then_i_am_redirected_to_sign_in
    expect(page.current_path).to eq new_user_session_path
  end
end
