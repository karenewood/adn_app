module EvalTestsHelper

def correct_test_user?(id)
   @eval_test = EvalTest.find(id)
   @user = User.find(@eval_test.user.id)
   current_user?(@user)
end

end
