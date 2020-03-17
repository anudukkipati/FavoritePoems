class PoemsController < ApplicationController

    #poems_path
    def index
      @poems = Poem.all
    end

    def new
        #if params[:user_id] && @user = User.find_by(id: params[:user_id])
         # @poem = @user.poems.build
        #else
          @poem = Poem.new
       # end
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
      @poem = Poem.find_by(id: params[:id])
      redirect_to poems_path if !@poem
    end

    def edit
      @poem = Poem.find_by(id: params[:id])
      redirect_to poems_path if !@poem || @poem.user != current_user
    end
    
    def update
      @poem = Poem.find_by(id: params[:id])
      redirect_to poems_path if !@poem || @poem.user != current_user
     if @poem.update(poem_params)
       redirect_to poem_path(@poem)
     else
       render :edit
     end
   end
    private
      def poem_params
        params.require(:poem).permit(:title,:content)
      end
end
