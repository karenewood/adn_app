class EvaluationsController < ApplicationController
  def new
    @evaluation = Evaluation.new
  end

  def create
    @evaluation = current_user.evaluations.build(params[:evaluation]) if signed_in?
    if @evaluation.save
      flash[:success] = "Nouvelle evaluation cree!"
      redirect_to @evaluation
    else
      render 'new'
    end
  end

  def show
    @evaluation = Evaluation.find(params[:id])
  end

  def index
    @evaluations = Evaluation.order(:name)
  end

  def edit
   @evaluation = Evaluation.find(params[:id])
  end

  def destroy
    Evaluation.find(params[:id]).destroy
    flash[:success] = "Evaluation supprime."
    redirect_to evaluations_url
  end

  def update
    @evaluation = Evaluation.find(params[:id])
    if @evaluation.update_attributes(params[:evaluation])
      flash[:success] = "Evaluation modifier"
      redirect_to @evaluation
    else
      render 'edit'
    end
  end


  private

  def correct_user_for_evaluation
      @evaluation = Evaluation.find(params[:id])
      @user = User.find(@evaluation.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end
end
