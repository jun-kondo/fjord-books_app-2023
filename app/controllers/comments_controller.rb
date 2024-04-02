# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to polymorphic_path(comment.commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to polymorphic_path(comment.commentable), alert: t('controllers.common.alert_not_created', name: Comment.model_name.human)
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to polymorphic_path(comment.commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(commentable_id: params[:commentable_id], commentable_type: params[:commentable_type], user_id: current_user.id)
  end
end
