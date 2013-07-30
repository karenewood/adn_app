class ExercisesController < ApplicationController
  include SessionsHelper

  before_filter :signed_in_user, only: [:edit, :update, :destroy, :new]
  before_filter :correct_user_for_exercise,   only: [:edit, :update, :destroy]

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = Exercise.new
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def index
    @exercises = Exercise.order(:name)
  end

  def create
    @exercise = current_user.exercises.build(params[:exercise]) if signed_in?
    if @exercise.save
      flash[:success] = "Nouvelle exercise cree!"
      redirect_to @exercise
    else
      render 'new'
    end
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update_attributes(params[:exercise])
      flash[:success] = "Exercice modifier"
      redirect_to @exercise
    else
      render 'edit'
    end
  end

  def destroy
    Exercise.find(params[:id]).destroy
    flash[:success] = "Exercise supprime."
    redirect_to exercises_url
  end

  private

  def correct_user_for_exercise
      @exercise = Exercise.find(params[:id])
      @user = User.find(@exercise.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end
end
