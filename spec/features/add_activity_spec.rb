require 'rails_helper'

feature 'AddActivity' do
  include Devise::Test::IntegrationHelpers
  scenario 'Adding an activity' do
    given_i_am_logged_in
    when_i_add_activity
    then_i_am_redirected_to_activity
    and_it_shows_me_last_distance_and_weekly_distance
    and_the_activity_should_appear_in_my_statistics
  end

  def given_i_am_logged_in
    @user = FactoryBot.create(:user)
    login_as @user
  end

  def when_i_add_activity
    visit '/'
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
    visit statistics_path
    today_date = Date.today.strftime("%d. %B")
    expect(page).to have_content(today_date)
    expect(page).to have_content("2.75 km")
  end
end
