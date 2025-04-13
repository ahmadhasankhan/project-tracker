# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_project
  def create
    @project.comments.create(content: comment_params[:content], user: current_user)
    redirect_to @project
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
