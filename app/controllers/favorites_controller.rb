class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def show
        @microposts = current_user.my_favorite_microposts
    end

    def create
        @micropost = Micropost.find(params[:id])
        return redirect_to root_url if @micropost.nil?
        current_user.add_favorite(@micropost)
        redirect_to (:back)
    end
    
    def destroy
        @micropost = current_user.my_favorite_microposts.find(params[:id])
        current_user.remove_favorite(@micropost)
        redirect_to (:back)
    end    

end
