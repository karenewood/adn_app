class EvalTestsController < ApplicationController
  include SessionsHelper

  before_filter :signed_in_user, only: [:edit, :update, :destroy, :new]
  before_filter :correct_user_for_test,   only: [:edit, :update, :destroy]

  def show
    @eval_test = EvalTest.find(params[:id])
  end

  def new
  	@eval_test = EvalTest.new
  end

  def edit
    @eval_test = EvalTest.find(params[:id])
  end

  def index
    @eval_tests = EvalTest.order(:name)
  end

  def create
    @eval_test = current_user.eval_tests.build(params[:eval_test]) if signed_in?
    if @eval_test.save
      flash[:success] = "Nouveau test cree!"
      redirect_to @eval_test
    else
      render 'new'
    end
  end

  def update
    @eval_test = EvalTest.find(params[:id])
    if @eval_test.update_attributes(params[:eval_test])
      flash[:success] = "Test modifier"
      redirect_to @eval_test
    else
      render 'edit'
    end
  end

  def destroy
    EvalTest.find(params[:id]).destroy
    flash[:success] = "Test supprime."
    redirect_to eval_tests_url
  end

private

  def correct_user_for_test
      @eval_test = EvalTest.find(params[:id])
      @user = User.find(@eval_test.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end

end
