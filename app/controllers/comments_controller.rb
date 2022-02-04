class CommentsController < ApplicationController
  def create
    @event_log = EventLog.find(params[:event_log_id])
    @comment = @event_log.comments.create(comment_params)
    redirect_to event_log_path(@event_log)
  end

  def destroy
    @event_log = EventLog.find(params[:event_log_id])
    @comment = @event_log.comments.find(params[:id])
    @comment.destroy
    redirect_to event_log_path(@event_log), status: 303
  end

  def edit
    @event_log = EventLog.find(params[:event_log_id])
    @comment = @event_log.comments.find(params[:id])
    puts @comment.body.to_s
  end

  def update
    @event_log = EventLog.find(params[:event_log_id])
    @comment = @event_log.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @event_log
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
