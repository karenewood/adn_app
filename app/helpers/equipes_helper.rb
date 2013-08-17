module EquipesHelper

	def correct_equipe_user?(id)
     @equipe = Equipe.find(id)
     @user = User.find(@equipe.user.id)
     current_user?(@user)
	end
end
