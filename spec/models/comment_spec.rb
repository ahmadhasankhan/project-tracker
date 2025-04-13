# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'is valid with content, project, and user' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'is invalid without content' do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:content]).to include("can't be blank")
    end

    it 'is invalid without a project' do
      comment = build(:comment, project: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:project]).to include('must exist')
    end

    it 'is invalid without a user' do
      comment = build(:comment, user: nil)
      expect(comment).not_to be_valid
      expect(comment.errors[:user]).to include('must exist')
    end
  end
end
