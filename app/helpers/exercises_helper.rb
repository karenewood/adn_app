module ExercisesHelper

  def correct_exercise_user?(id)
     @exercise = Exercise.find(id)
     @user = User.find(@exercise.user.id)
     current_user?(@user)
  end
end
