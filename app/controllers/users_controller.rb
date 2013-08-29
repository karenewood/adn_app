class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @resultats = Resultat.where(:athlete_id => @user.id).
                          select("date(created_at) as eval_day, evaluation_id, user_id, equipe_id, min(id) as id").
                          group("eval_day, evaluation_id, user_id, equipe_id").
                          order("eval_day DESC")  
    @equipes = @user.equipes
    params[:resultats] = @resultats
    params[:equipes] = @equipes
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bienvenue a solution ADN!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
private

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

  def store_location
    session[:return_to] = request.url
  end
end
