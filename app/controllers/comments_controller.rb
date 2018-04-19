class CommentsController < ApplicationController
    before_action :user_authorized, only: [:create]
    def create
        comment = Comment.create(comment_params)
        if comment.valid?
            redirect_to "/events/#{params[:event_id]}"
        else
            flash[:errors] = comment.errors.full_messages
            redirect_to "/events/#{params[:event_id]}"
        end   
    end

    def delete
        Comment.find(params[:comment_id]).destroy
        redirect_to "/events/#{params[:event_id]}"
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :event_id)
    end
end
