# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActivitiesController, type: :controller do
  include Devise::Test::ControllerHelpers

  it 'has a valid factory' do
    expect(FactoryBot.create(:activity)).to be_valid
    expect(FactoryBot.create(:user)).to be_valid
  end

  let(:user) { FactoryBot.create(:user) }
  before { sign_in user }

  let(:activity) { FactoryBot.create(:activity, user_id: user.id) }
  subject { activity }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the :new view' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #create' do
    let(:action) do
      post :create, params: { activity: {
        start_point: 'Plac Europejski 2, Warszawa, Polska',
        end_point: 'Andersa 2, Warszawa, Polska'
      } }
    end
    context 'with valid attributes' do
      it 'create new activity' do
        expect { action }.to change { Activity.count }.by(1)
      end

      it 'redirects to the new activity' do
        action
        expect(response).to redirect_to Activity.last
      end
    end

    context 'with invalid attributes' do
      let(:action) do
        post :create, params: { activity: {
          start_point: 'aaaaa, Warszawa, Polska',
          end_point: 'bbbbb, Warszawa, Polska'
        } }
      end
      it "doesn't create a new activity" do
        expect { action }.to_not change { Activity.count }
      end

      it 're-renders the new method' do
        action
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    let(:another_user) { FactoryBot.create(:user) }

    before :each do
      get :show, params: { id: activity.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested activity to @activity' do
      expect(assigns(:activity)).to eq(activity)
    end

    it 'renders the :show view' do
      expect(response).to render_template(:show)
    end

    it 'displays the last distance' do
      FactoryBot.create(:activity, user_id: user.id, created_at: 8.days.ago)
      FactoryBot.create(:activity, user_id: another_user.id)
      FactoryBot.create(:activity, user_id: user.id)
      get :show, params: { id: activity.id }
      expect(assigns(:weekly_distance)).to eq(activity.distance * 2)
    end
  end
end
