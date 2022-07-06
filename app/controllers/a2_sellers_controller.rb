class A2SellersController < ApplicationController
  def main
    if (params[:workgroupe] == "Покупатель") ; redirect_to custumers_index_path ; end
    @materials = (params[:seller_id]) ? Material.active(params[:seller_id]) : Material.active(current_user.id) ; 
  end

  def requests
    @requests = (params[:seller_id]) ? Request.for_user(params[:seller_id]) : Request.for_user(current_user.id);
  end
    
  def to_moderate
    Material.to_modareting(params[:mat_id])
    redirect_to request.referrer
  end
    
  def mat_delete
    Material.find(params[:mat_id]).destroy
    redirect_to request.referrer
  end 
  
      # def mat_deleteeeeeee
      #   if user_signed_in?
      #     Request.find(params[:id]).update("seller_side":false)
      #     redirect_to sellers_requests_path
      #   end
      # end
    
   
end
