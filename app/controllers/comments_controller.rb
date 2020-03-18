class CommentsController < ApplicationController
   
  before_action :redirect_if_not_logged_in
  before_action :set_comment, only: [:show, :edit, :update]
  before_action :redirect_if_not_comment_author, only: [:edit, :update]

 def index
   if params[:poem_id] && @poem = Poem.find_by_id(params[:poem_id])
      @comments = @poem.comments
   else
    
     @comments = Comment.all
   end
 end

 def new
   
   if params[:poem_id] && @poem = Poem.find_by_id(params[:poem_id])
     @comment = @poem.comments.build
   else
     
     @comment = Comment.new
   end
 end

 def create
   @comment = current_user.comments.build(comment_params)
   if @comment.save
     redirect_to comments_path
   else
     render :new
   end
 end


 def show
 end

 def edit
 end

 def update
   if @comment.update(comment_params)
     redirect_to comment_path(@comment)
   else
     render :edit
   end
 end

 private

 def comment_params
   params.require(:comment).permit(:content,:poem_id)
 end

 def set_comment
   @comment = Comment.find_by(id: params[:id])
   if !@comment
    # flash[:message] = "Comment was not found"
     redirect_to comments_path, alert: "Comment was not found"
   end
 end

 def redirect_if_not_comment_author
    redirect_to comments_path if @comment.user != current_user
 end
        

end
