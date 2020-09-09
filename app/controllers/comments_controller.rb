class CommentsController < ApplicationController
   
  before_action :redirect_if_not_logged_in
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_authorised, only: [:edit, :update, :destroy]

  def index
    if params[:poem_id] && @poem = Poem.find_by(id: params[:poem_id])
        @comments = @poem.comments
    else
      
      @comments = Comment.all
    end
  end

  def new
    
    if params[:poem_id] && @poem = Poem.find_by(id: params[:poem_id])
      @comment = @poem.comments.build
    else
      
      @comment = Comment.new(poem_id: params[:poem_id])
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      
      redirect_to comment_path(@comment)
      
    else
      @poem = Poem.find_by(id: params[:poem_id]) 
      render :new
    end
  end


  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def edit
    if params[:poem_id] && @poem = Poem.find_by(id: params[:poem_id])
      if @poem.nil?
          flash[:alert] = "Poem doesn't exist!"
        redirect_to poems_path
      else
    
        @comment = @poem.comments.find_by(id: params[:id])
      end
      else
        @comment = Comment.find_by(id: params[:id])
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end
  
  def destroy
    @poem = Poem.find_by(id: params[:poem_id])
    @comment.destroy
    redirect_to poem_comments_path(@poem)
    end
  private

  def comment_params
    params.require(:comment).permit(:content,:poem_id)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    if !@comment
      flash[:alert] = "Comment was not found"
      redirect_to comments_path
    end
  end

  def redirect_if_not_authorised
      redirect_to comments_path if @comment.user != current_user
  end
        

end
