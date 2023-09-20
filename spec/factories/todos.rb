# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { '勉強中です' }
    description { 'プログラミング学習です' }
    status { :not_started }
  end

  trait :done do
    status { :done }
  end

  trait :in_progress do
    status { :in_progress }
  end
end
