class EquipesController < ApplicationController
	include SessionsHelper

  before_filter :signed_in_user, only: [:edit, :update, :destroy, :new]
  before_filter :correct_user_for_equipe,   only: [:edit, :update, :destroy]

  def new
  	@equipe = Equipe.new
  end

  def create
    @equipe = current_user.ownedteams.build(params[:equipe]) if signed_in?
    if @equipe.save
      flash[:success] = "Ajouter les Athletes..."
      render 'edit'
    else
      render 'new'
    end
  end

  def show
    @equipe = Equipe.find(params[:id])
  end

  def index
    @equipes = Equipe.order(:name)
  end

  def update
    @equipe = Equipe.find(params[:id])
    if @equipe.update_attributes(params[:equipe])
      flash[:success] = "Equipe modifier"
      redirect_to @equipe
    else
      render 'edit'
    end
  end

  def destroy
    Equipe.find(params[:id]).destroy
    flash[:success] = "Equipe supprime."
    redirect_to equipes_url
  end

  private

  def correct_user_for_equipe
      @equipe = Equipe.find(params[:id])
      @user = User.find(@equipe.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end
end