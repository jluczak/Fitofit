# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:activity)).to be_valid
  end

  let(:activity) { FactoryBot.create(:activity) }
  subject { activity }

  describe 'database columns' do
    it { is_expected.to have_db_column :start_point }
    it { is_expected.to have_db_column :end_point }
    it { is_expected.to have_db_column :distance }
  end

  describe 'validations' do
    it { expect(subject).to validate_presence_of(:start_point) }
    it { expect(subject).to validate_presence_of(:end_point) }
    it { expect(subject).to validate_presence_of(:distance) }
    it { expect(subject).to validate_numericality_of(:distance).is_greater_than(0) }
  end

  describe 'relations' do
    it { should belong_to :user }
  end
end
