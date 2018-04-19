class EventsController < ApplicationController
  before_action :user_authorized, only: [:index, :create, :show, :showedit]
  def index
    current_user = current_user()
    @event_samestate = Event.where(state: "#{current_user.state}")
    @event_otherstate = Event.where.not(state: "#{current_user.state}")
    @joined_events_ids = current_user.events_joined_ids
  end

  def create
    event = Event.create(event_params)

    if event.valid?
      redirect_to '/events'
    else
      flash[:errors] = event.errors.full_messages
      redirect_to '/events'
    end
  end

  def show
    @current_event = Event.find(params[:event_id])
    @current_user = current_user()
  end

  def destroy
    Event.find(params[:event_id]).destroy
    redirect_to "/events"
  end

  def showedit
    @event = Event.find(params[:event_id])
  end

  def editprocess
    event = Event.find(params[:event_id])
    event.update(event_params)

    if event.save
      redirect_to "/events"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/events/edit/#{params[:event_id]}"
    end
  end

  private
    def event_params
      params.require(:event).permit(:name,:date,:city,:state,:user_id)
    end
end
