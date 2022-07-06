class A4ModeratorsController < ApplicationController
  def mod1_sellers;   @users = User.sellers; end
  
  def mod2_custumers; @users = User.custumers; end
    
  def mod3_moderate
    @materials = Material.where(to_moderating:true)
    @logs = Log.logs
  end  
  
  def mod4_config 
    @users = User.moderators
    if YookassaDatum.last
      @yookassa_data = YookassaDatum.last
    end
  end  
  
  def edit_user
    @user = User.find(params[:id])
    @url_back = request.referrer
  end

  def update_user
    User.find(params[:id]).update(user_params)
    redirect_to params[:url_back]
  end
  
  private
  def user_params
    params.require(:user).permit(:company, :phone, :workgroupe, :email, :copy_pass, :password, :url_back)
  end
end
