module EvaluationsHelper

def correct_evaluation_user?(id)
   @evaluation = Evaluation.find(id)
   @user = User.find(@evaluation.user.id)
   current_user?(@user)
end

end
