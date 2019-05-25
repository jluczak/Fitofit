# frozen_string_literal: true

require 'rails_helper'

describe AddressValidator do
  subject { Validatable.new(start_point: start_point, end_point: end_point) }

  shared_examples 'has valid address' do
    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

  shared_examples 'has invalid address' do
    it 'should not be valid' do
      expect(subject).not_to be_valid
    end
  end

  context 'with normal addresses' do
    let(:start_point) { 'Plac Europejski 2, Warszawa, Polska' }
    let(:end_point) { 'Andersa 2, Warszawa, Polska' }
    it_behaves_like 'has valid address'
  end

  context 'with polish characters' do
    let(:start_point) { 'Bełżecka 5/10, Warszawa, Polska' }
    let(:end_point) { 'Biały Kamień 3, Warszawa, Polska' }
    it_behaves_like 'has valid address'
  end

  context 'non-existent' do
    let(:start_point) { 'Elpassionówko 21, Warszawa, Polska' }
    let(:end_point) { 'Krakersy 10, Warszawa, Polska' }
    it_behaves_like 'has invalid address'
  end

  context 'wrong order' do
    let(:start_point) { 'Warszawa, Plac Europejski 2, Polska' }
    let(:end_point) { 'Warszawa, Andersa 2, Polska' }
    it_behaves_like 'has invalid address'
  end

  context 'same address' do
    let(:start_point) { 'Plac Europejski 2, Warszawa, Polska' }
    let(:end_point) { 'Plac Europejski 2, Warszawa, Polska' }
    it_behaves_like 'has invalid address'
  end
end

class Validatable
  include ActiveModel::Validations
  validates_with AddressValidator, attributes: %i[start_point end_point]
  attr_accessor :start_point, :end_point

  def initialize(start_point:, end_point:)
    @start_point = start_point
    @end_point = end_point
  end
end
