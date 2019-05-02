class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :is_the_same_user?, only: [:edit, :update, :destroy]
  def index
    @gossip = Gossip.all
  end

  def show
    @gossip_precis = Gossip.find(params[:id])
    @gossip_user_id = @gossip_precis.user_id
    @gossip_user_city_id = User.find(@gossip_user_id).city_id
    @gossip_user_city = City.find(@gossip_user_city_id).name
    # @comment = Comment.new
  end  

  def new
    @gossip_new = Gossip.new
  end

  def create
    @gossip_new = Gossip.new(title: params[:title], content: params[:content], user: current_user)
    @gossip_new.save

    if @gossip_new.save
    	redirect_to action:'index'
    	flash[:success] = "Your gossip has been registered with success, my coño friend!"
    else
    	render 'new'
    end

    puts @gossip_new.user 
  end

  def edit
    @gossip_precis = Gossip.find(params[:id])
  end

  def update
    @gossip_precis = Gossip.find(params[:id])

    if @gossip_precis.update(gossip_params)
      redirect_to action:'index'
      flash[:success] = "Your gossip has been edited with success, my coño friend!"
    else
      flash[:alert] = "Try again, my coño friend!"
      render :edit

    end
  end

  def destroy
    @gossip_precis = Gossip.find(params[:id])
    @gossip_precis.destroy
    redirect_to action: 'index'
    flash[:success] = "Your gossip has been deleted with success, my coño friend!"
  end


  private

  def gossip_params

    params.require(:gossip).permit(:title, :content)

  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end

private

def is_the_same_user?
  @gossip_precis = Gossip.find(params[:id])
  if logged_in?
    unless current_user.id == @gossip_precis.user_id
      flash[:danger] = "You cannot modify a gossip which is not yours"
      redirect_back fallback_location: root_path
    end
  else
    flash[:danger] = "You have to be logged to do this action"
    redirect_back fallback_location:root_path
  end
end

