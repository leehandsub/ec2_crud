class ReplyController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @reply = Reply.new
    @reply.content = params[:content]
    @reply.post_id = params[:id]
    @reply.user_id = current_user.id
    @reply.save
    
    redirect_to "/post/view/" + params[:id]
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    
    redirect_to '/post/view/' + @reply.post_id.to_s
  end
end
