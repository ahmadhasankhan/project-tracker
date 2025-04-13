# frozen_string_literal: true

class Project < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, completed: 2 }

  has_many :comments, dependent: :destroy
  has_many :project_histories, dependent: :destroy

  validates :name, :status, presence: true

  def full_history
    (comments + project_histories).sort_by(&:created_at).reverse
  end

  def log_status_change_by(user)
    return unless saved_change_to_status?

    ProjectHistory.create!(
      project: self,
      user: user,
      from_status: status_before_last_save,
      to_status: status
    )
  end
end
