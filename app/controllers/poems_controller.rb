class PoemsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_poem, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_authorised, only: [:edit, :update]
    #poems_path
    def index
      @poems = Poem.all.alphabetical
      @comments = Comment.all
    end

    def new
          @poem = Poem.new
    end

    def create
        @poem = current_user.poems.build(poem_params)
        if @poem.save
          redirect_to poems_path
        else
          render :new
        end
    end

    def show
     # @poem = Poem.find_by(id: params[:id])
      redirect_to poems_path if !@poem
    end

    def edit
     # @poem = Poem.find_by(id: params[:id])
      #redirect_to poems_path if !@poem || @poem.user != current_user
    end
    
    def update
     # @poem = Poem.find_by(id: params[:id])
      #redirect_to poems_path if !@poem || @poem.user != current_user
     if @poem.update(poem_params)
       redirect_to poem_path(@poem)
     else
       render :edit
     end
   end

   def destroy
   # @poem = Poem.find_by(id: params[:id])
    @poem.destroy
    redirect_to poems_path
   end
    private
      def poem_params
        params.require(:poem).permit(:title,:content)
      end

      def set_poem
        @poem = Poem.find_by(id: params[:id])
      end

      def redirect_if_not_authorised
        
        redirect_to poems_path if !@poem || @poem.user != current_user
     end
end
