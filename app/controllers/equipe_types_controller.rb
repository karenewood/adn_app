class EquipeTypesController < ApplicationController
  include SessionsHelper

  before_filter :signed_in_user, only: [:edit, :update, :destroy, :new]
  before_filter :correct_user_for_equipe_type,   only: [:edit, :update, :destroy]

  # GET /equipe_types
  # GET /equipe_types.json
  def index
    @equipe_types = EquipeType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @equipe_types }
    end
  end

  # GET /equipe_types/1
  # GET /equipe_types/1.json
  def show
    @equipe_type = EquipeType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @equipe_type }
    end
  end

  # GET /equipe_types/new
  # GET /equipe_types/new.json
  def new
    @equipe_type = EquipeType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @equipe_type }
    end
  end

  # GET /equipe_types/1/edit
  def edit
    @equipe_type = EquipeType.find(params[:id])
  end

  # POST /equipe_types
  # POST /equipe_types.json
  def create
    @equipe_type = EquipeType.new(params[:equipe_type])

    respond_to do |format|
      if @equipe_type.save
        format.html { redirect_to @equipe_type, notice: 'Equipe type was successfully created.' }
        format.json { render json: @equipe_type, status: :created, location: @equipe_type }
      else
        format.html { render action: "new" }
        format.json { render json: @equipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /equipe_types/1
  # PUT /equipe_types/1.json
  def update
    @equipe_type = EquipeType.find(params[:id])

    respond_to do |format|
      if @equipe_type.update_attributes(params[:equipe_type])
        format.html { redirect_to @equipe_type, notice: 'Equipe type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipe_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipe_types/1
  # DELETE /equipe_types/1.json
  def destroy
    @equipe_type = EquipeType.find(params[:id])
    @equipe_type.destroy

    respond_to do |format|
      format.html { redirect_to equipe_types_url }
      format.json { head :no_content }
    end
  end

  def correct_user_for_equipe_type
      @equipe_type = EquipeType.find(params[:id])
      @user = User.find(@equipe_type.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end
end
