# frozen_string_literal: true

require 'rails_helper'

feature 'Statistics' do
  include Devise::Test::IntegrationHelpers
  scenario 'Displaying accurate statistics as logged in user' do
    given_i_am_logged_in
    and_there_are_some_activities
    when_i_visit_statistics
    then_statistics_should_display_my_activities
  end

  scenario 'Displaying accurate statistics as not logged in user' do
    when_i_visit_statistics
    then_i_am_redirected_to_sign_in
  end

  def given_i_am_logged_in
    @user = FactoryBot.create(:user)
    login_as @user
  end

  def and_there_are_some_activities
    @this_month = Date.today.strftime('%B')
    another_user = FactoryBot.create(:user)
    FactoryBot.create_list(:activity, 2, created_at: "2019-#{@this_month}-22", user_id: @user.id)
    FactoryBot.create(:activity, created_at: "2019-#{@this_month}-24", user_id: @user.id)
    FactoryBot.create(:activity, created_at: "2019-#{@this_month}-26", user_id: another_user.id)
    FactoryBot.create(:activity, created_at: '2017-07-26', user_id: @user.id)
  end

  def when_i_visit_statistics
    visit statistics_path
  end

  def then_statistics_should_display_my_activities
    visit statistics_path
    expect(page).to have_content("22. #{@this_month}")
    expect(page).to have_content("24. #{@this_month}")
    expect(page).to have_content('2.4 km')
    expect(page).to have_content('4.8 km')
  end

  def but_should_not_display_other_users_activities
    expect(page).not_to have_content("26. #{@this_month}")
  end

  def and_should_only_display_this_month_activities
    expect(page).not_to have_content('26. July')
  end

  def then_i_am_redirected_to_sign_in
    expect(page.current_path).to eq new_user_session_path
  end
end
