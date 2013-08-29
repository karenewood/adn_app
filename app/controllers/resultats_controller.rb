class ResultatsController < ApplicationController

	def new_team
  	  @resultat = Resultat.new
  end

  def new_athlete
      @resultat = Resultat.new
  end

  def index
    @resultats = Resultat.select("date(created_at) as eval_day, evaluation_id, user_id, min(id) as id").
                          group("eval_day, evaluation_id, user_id").
                          order("eval_day DESC")  
  end

  def index_detail
    @first_record = Resultat.find(params[:resultat_id])
    timestamp = @first_record.created_at
    eval_id = @first_record.evaluation_id
    evaluator = @first_record.user_id
    @resultats = Resultat.where(:evaluation_id => eval_id, 
                                :user_id => evaluator,
                                :created_at => (timestamp - 2.hours)..(timestamp + 2.hours)).
                          select("athlete_id, equipe_id, min(created_at) as created_at, 
                                                         min(evaluation_id) as evaluation_id,
                                                         min(user_id) as user_id, 
                                                         min(id) as id").
                          group("athlete_id, equipe_id").
                          order("equipe_id ASC")
  end

  def athlete
    @first_record = Resultat.find(params[:resultat_id])
    timestamp = @first_record.created_at
    eval_id = @first_record.evaluation_id
    athlete_id = @first_record.athlete_id
    evaluator = @first_record.user_id
    @resultats = Resultat.where(:evaluation_id => eval_id, 
                                :user_id => evaluator,
                                :created_at => (timestamp - 2.hours)..(timestamp + 2.hours),
                                :athlete_id => athlete_id)
  end

  def programme_corrective
    @first_record = Resultat.find(params[:resultat_id])
    timestamp = @first_record.created_at
    eval_id = @first_record.evaluation_id
    athlete_id = @first_record.athlete_id
    evaluator = @first_record.user_id
    resultats = Resultat.where(:evaluation_id => eval_id, 
                                :user_id => evaluator,
                                :created_at => (timestamp - 2.hours)..(timestamp + 2.hours),
                                :athlete_id => athlete_id)
    @exercises = Array.new
    resultats.each do |resultat|
      resultat.eval_test.exercises.each do |exercise|
        @exercises << exercise
      end
    end
    params[:exercises] = @exercises
  end


  def show
    @resultat = Resultat.find(params[:id])
  end

  def edit
    @resultat = Resultat.find(params[:id])
  end

  def update
    @resultat = Resultat.find(params[:id])
    if @resultat.update_attributes(params[:resultat])
      flash[:success] = "Resultat modifier"
      redirect_to @resultat
    else
      render 'edit'
    end
  end

	def create
    session[:tests_complete] = 0
    session[:evaluation_id] = (params[:resultat][:evaluation_id])
    session[:equipe_id] = (params[:resultat][:equipe_id])
    session[:athlete_id] = (params[:resultat][:athlete_id])
    @resultats = create_test_resultats
    render 'prise_de_donnees'
  end

  def destroy
    Resultat.destroy_all
    flash.now[:success] = "Resultats supprime."
    redirect_to resultats_url
  end

  def prise_donnees
      @resultat = Resultat.update(params[:resultats].keys, params[:resultats].values).reject { |p| p.errors.empty? }
      if result_values_OK?  == false
        @resultats = Array.new
        params[:resultats].keys.each do |resultat_id|
          resultat = Resultat.find(resultat_id)
          @resultats << resultat
        end
        @eval_test = get_test
        flash.now[:error] = "Une ou plusieurs donnees non-remplies"
        render "prise_de_donnees"
      else
          flash.now[:notice] = "Resultats du test enregistrer"
          session[:tests_complete] += 1
          @resultats = create_test_resultats
          if @resultats != nil
            render 'prise_de_donnees'
          else
            if session[:equipe_id] == nil
            @resultats_final = Resultat.where("created_at >= ?", 2.hours.ago).
                                        where(:user_id => current_user.id,
                                              :athlete_id => session[:athlete_id])
            else
            @resultats_final = Resultat.where("created_at >= ?", 2.hours.ago).
                                        where(:user_id => current_user.id,
                                              :equipe_id => session[:equipe_id]).
                                        order("athlete_id")
            end
            @first_record = @resultats_final.first
            render 'evaluation_complete'
          end
      end
  end

  private

  def correct_user_for_resultat
      @resultat = Resultat.find(params[:id])
      @user = User.find(@resultat.user.id)
      redirect_to(root_path) unless current_user?(@user)
  end

  def get_athletes
    athlete_users = Array.new
    if !(session[:equipe_id])
      athlete_users << User.find(session[:athlete_id])
    else
      athlete_users = Equipe.find(session[:equipe_id]).users
    end
    return athlete_users
  end


  def create_test_resultats
    resultats = Array.new
    athletes = get_athletes
    @eval_test = get_test
    if @eval_test != nil
      athletes.each do |athlete|
          resultat = current_user.resultats.build(:athlete_id => athlete.id,
                               :evaluation_id => session[:evaluation_id],
                               :equipe_id => session[:equipe_id],
                               :eval_test_id => @eval_test.id,
                               :value => 99) if signed_in?
          resultat.save
          resultats << resultat
        end
      return resultats
    else
      return nil
    end
  end

  def get_test
   tests = Array.new 
   tests = Evaluation.find(session[:evaluation_id]).eval_tests
   tests.shift(session[:tests_complete])
   eval_test = tests.shift
   return eval_test
  end

  def result_values_OK?
    return_value = true
    if !@resultat.empty?
      return_value = false
    end
    params[:resultats].values.each do |resultat|
      if resultat[:value] == '99'
         return_value = false
      end
    end
    return return_value
  end

end
