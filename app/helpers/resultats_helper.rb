module ResultatsHelper

def correct_resultat_user?(id)
   @resultat = Resultat.find(id)
   @user = User.find(@resultat.user.id)
   current_user?(@user)
end

end
