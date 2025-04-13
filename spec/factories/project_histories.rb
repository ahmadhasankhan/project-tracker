# frozen_string_literal: true

FactoryBot.define do
  factory :project_history do
    from_status { 'pending' }
    to_status { 'in_progress' }
    association :project
    association :user
  end
end
