# frozen_string_literal: true

json.extract! project, :id, :name, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
