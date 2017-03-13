class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    event=Event.find(params[:event_id])
    comment.event = event
    comment.account = current_user
    if comment.valid?
      comment.save
      redirect_to event
    else
      flash[:error]= comment.errors.full_messages[0]
      redirect_to event
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
