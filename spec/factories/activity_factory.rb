FactoryBot.define do
  factory :activity, class: Activity do
    start_point { 'Plac Europejski 2, Warszawa, Polska' }
    end_point { 'Andersa 2, Warszawa, Polska' }
    distance { 2.4 }
    association :user
  end
end
