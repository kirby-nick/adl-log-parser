class EventLogsController < ApplicationController
  def index
    @event_logs = EventLog.all
  end

  def show
    @event_log = EventLog.find(params[:id])
  end

  def new
    @event_log = EventLog.new
  end

  def edit
    @event_log = EventLog.find(params[:id])
  end

  def update
    @event_log = EventLog.find(params[:id])
    if @event_log.update(event_log_params)
      redirect_to @event_log
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create
    @event_log = EventLog.new(event_log_params)
    if @event_log.save
      redirect_to @event_log
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @event_log = EventLog.find(params[:id])
    if @event_log.destroy
      redirect_to event_logs_path, status: :see_other
    end
  end

  private

  def event_log_params
    params.require(:event_log).permit(:body)
  end
end
