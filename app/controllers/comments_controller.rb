class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    post = Post.find(params[:post_id])
    params[:comment][:user_id] = current_user.id
    @comment = post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render json: post, status: :created, location: post}
      else
        format.html { redirect_to :back, alert: 'Comment was not successfully created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    if current_user==@post.user
      @comment = @post.comments.find(params[:id])
      @comment.destroy

      respond_to do |format|
        format.html { redirect_to :back, notice: 'Comment deleted.' }
        format.json { head :no_content }
      end
    else
         redirect_to :back, alert: 'Do not do that.'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end
