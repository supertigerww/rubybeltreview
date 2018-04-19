class JoinsController < ApplicationController
    before_action :user_authorized, only: [:create]

    def create
        Join.create(user: current_user, event:Event.find(params[:event_id]))
        redirect_to '/events'
    end

    def destroy
        Join.find_by(user: current_user, event:Event.find(params[:event_id])).destroy
        redirect_to '/events'
    end

end
