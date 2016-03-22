class FavoritesController < ApplicationController
    before_action :logged_in_user
    
    def create
        logger.debug (params[:id]) 
        logger.debug (params[:micropost_id]) 
        logger.debug (params[:micropost_params]) 
        @micropost = Micropost.find(params[:id])
        # @micropost = Micropost.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        current_user.add_favorite(@micropost)
    end
    
    def destroy
        @micropost = current_user.my_favorite_microposts.find(params[:id]).micropost
        current_user.remove_favorite(@micropost)
    end    

end
