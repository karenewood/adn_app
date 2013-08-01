module ProgrammesHelper

	def correct_programme_user?(id)
      @programme = Programme.find(id)
      @user = User.find(@programme.user.id)
      current_user?(@user)
	end

end
