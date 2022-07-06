class FetchRequestsController < ApplicationController
  def delete_user
    User.find(params[:id]).destroy
    redirect_to request.referrer
  end 
  
  def mat_active
    cur_user = User.find(params[:current_user_id])
    cur_mat = Material.find(params[:mat_id])
    cur_mat.update(to_moderating:false, active:true)
    Log.create(moderator_name:cur_user.company,
      action:"Публикация",
      material_name:cur_mat.description,
      unit:cur_mat.unit,
      price_retail:cur_mat.price_retail,
      price_wholesale:cur_mat.price_wholesale,
      amount_wholesale:cur_mat.amount_wholesale,
      date_material:cur_mat.created_at.strftime("%H:%M %d.%m.%y"))
  end
  
  def mat_delete
    cur_user = User.find(params[:current_user_id])
    cur_mat = Material.find(params[:mat_id]) 
    Log.create(moderator_name:cur_user.company,
      action:"Удаление",
      material_name:cur_mat.description,
      unit:cur_mat.unit,
      price_retail:cur_mat.price_retail,
      price_wholesale:cur_mat.price_wholesale,
      amount_wholesale:cur_mat.amount_wholesale,
      date_material:cur_mat.created_at.strftime("%H:%M %d.%m.%y")
    )
    cur_mat.destroy
  end
  
  def request_add
        if !Request.find_by(user_id:params[:user_id], material_id:params[:material_id])
          cur_material = Material.find(params[:material_id])
          for_user = User.find(cur_material[:user_id])
          Request.create(user_id:params[:user_id],
              material_id:params[:material_id],
              for_user_id:for_user.id,
              "custumer_side":"basket")
        end
        if Request.find_by(user_id:params[:user_id], material_id:params[:material_id],"custumer_side":"archive") 
          Request.find_by(user_id:params[:user_id], material_id:params[:material_id]).update("custumer_side":"basket")
        end
  end  
  
  def to_archive
    if user_signed_in? 
 
     if params[:user_id]
       requests = Request.where(user_id:params[:user_id])
     else
       requests = Request.where(user_id:current_user.id)
     end

     params.each do |key, value|
        if value == '1'
          requests.find_by(material_id:key.to_i).update("custumer_side":"archive", "seller_side": true)
        end
      end
     end
   end  
  
         
   def request_delete
    params.each do |key, value|
      if value == '1'
        Request.find_by(material_id:key.to_i, user_id:params[:custumer_id]).destroy
      end
    end
  end 
  
  def yookassa
    YookassaDatum.create(token:params[:yookassa_datum][:token], shop_id:params[:yookassa_datum][:shop_id])

    redirect_to request.referrer
  end
  
  def create_mod
    u = User.create(user_params)

    redirect_to request.referrer
  end 

  def get_all_materials; 

    # debugger
    mats = JSON.parse(Material.order(:description).all.to_json())
    ids = Material.order(:description).all.map(&:user_id)

    mats.each_with_index do |mat, index|
        u = User.find(ids[index])
        if (u.id != 18) 
          mat["company"] = u.company
        end
    end
  
    render json: mats;
  end

  def get_all_categories
    categories_all = Category.all
    categories_all_id = Category.all.map(&:id)

    categories_first_level    = Category.first_level
    categories_first_level_ids = categories_first_level.map(&:id)
   
    categories_second_level   = Category.all.select {|cat|  categories_first_level_ids.include?(cat.parent_id)}
    categories_second_level_ids = categories_second_level.map(&:id)

    categories_third_level_ids    = categories_all_id.difference(categories_first_level_ids, categories_second_level_ids)
    categories_third_level = Category.where(id:categories_third_level_ids)

@categories = [categories_first_level.order(:name), categories_second_level, categories_third_level, categories_all]
render json: @categories
end



def update_purse
  require 'net/http'

  key = "test_OovknISXXpCD3BtM3z-ZVr_1BU9OJYoesi8QmKAoais"
  shopId = "910379"

  to_update = Pay.where(handled:false) 
  to_update.each do |pay|
      user_pay = User.find(pay[:user_id])
      uri = URI("https://api.yookassa.ru/v3/payments/#{pay[:pay_id]}")
      req = Net::HTTP::Get.new(uri)
      req.basic_auth shopId, key
      
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
        http.request(req)
      }
      response = JSON.parse(res.body)
      

      case response['status']
      when "succeeded"
          if user_pay[:purse]
            sum = user_pay[:purse] + response["amount"]["value"].slice(0..-3).to_i
          else  
            sum = response["amount"]["value"].slice(0..-3).to_i
          end
          user_pay.update(purse:sum)
          pay.update(handled:true, status:"payed")
      when "pending"
          if Time.now.to_i - pay.created_at.to_i > 1000
              pay.update(handled:true, status:"long time")
          end
      else
          
      end
  end
  head :ok

end
  ################################################################
        
  def delete
    Request.find_by(user_id:params[:user_id], material_id:params[:material_id]).destroy
  end
        
  def create_mes
    if (params[:to_user_id] == "Покупатель")
      custumers = User.where(workgroupe:"Покупатель")
      custumers.each do|cust|
        Message.create(user_id:cust.id, from_user:params[:from_user_id], body:params[:body])
      end
    elsif (params[:to_user_id] == "Продавец")
      custumers = User.where(workgroupe:"Продавец")
      custumers.each do|cust|
        Message.create(user_id:cust.id, from_user:params[:from_user_id], body:params[:body])
      end
    else
      Message.create(user_id:params[:to_user_id], from_user:params[:from_user_id], body:params[:body])
    end
  end
      
  def mat_edit
    cur_user = User.find(params[:current_user_id])
    cur_mat = Material.find(params[:mat_id])
    
    Log.create(moderator_name:cur_user.company,
      action:"Изменение",
      material_name:cur_mat.description,
      unit:cur_mat.unit,
      price_retail:cur_mat.price_retail,
      price_wholesale:cur_mat.price_wholesale,
      amount_wholesale:cur_mat.amount_wholesale,
      date_material:cur_mat.created_at.strftime("%H:%M %d.%m.%y")
    )
  end

  private
    def user_params
      params.require(:user).permit(:company, :phone, :workgroupe, :email, :copy_pass, :password, :url_back)
    end
    
    
    
end
