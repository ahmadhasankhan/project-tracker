# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project, status: :pending, name: 'Test Project') }

  context 'validations' do
    it 'is valid with a name and status' do
      project = Project.new(name: 'Project Name', status: :pending)
      expect(project).to be_valid
    end

    it 'is invalid without a name' do
      project.name = nil
      expect(project).to_not be_valid
    end

    it 'is invalid without a status' do
      project.status = nil
      expect(project).to_not be_valid
    end
  end

  context 'full_history' do
    let!(:comm1) { create(:comment, project: project, user: user, content: 'First comment', created_at: 2.days.ago) }
    let!(:comm2) { create(:comment, project: project, user: user, content: 'Second comment', created_at: 1.day.ago) }
    let!(:history_1) { create(:project_history, project: project, user: user, from_status: 'pending',
                              to_status: 'in_progress', created_at: 3.days.ago) }
    let!(:history_2) { create(:project_history, project: project, user: user, from_status: 'in_progress',
                              to_status: 'completed', created_at: 1.day.ago) }

    it 'returns sorted comments and project histories' do
      history = project.full_history

      expect(history.first).to eq(history_2) # Second project_history_2, created 1 day ago
      expect(history[1]).to eq(comm2) # Second comment_2, created 1 day ago just before project history_2
      expect(history.last).to eq(history_1) # First project history, created 3 days ago
    end
  end

  context 'log_status_change_by' do
    it 'creates a project history record when status changes' do
      # Initial status is 'pending', so there should be no history yet.
      expect(project.project_histories.count).to eq(0)

      # Change the status and log the change
      project.update(status: :in_progress)
      project.log_status_change_by(user)

      # Check that the ProjectHistory record is created
      expect(project.project_histories.count).to eq(1)
      expect(project.project_histories.first.from_status).to eq('pending')
      expect(project.project_histories.first.to_status).to eq('in_progress')
      expect(project.project_histories.first.user).to eq(user)
    end

    it "does not create a project history record if status hasn't changed" do
      # No status change, so no history should be created.
      expect(project.project_histories.count).to eq(0)
      project.update(name: 'something else')
      project.log_status_change_by(user)

      expect(project.project_histories.count).to eq(0) # No history should be created
    end
  end
end
