# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'Test Project' }
    status { :pending }
  end
end
