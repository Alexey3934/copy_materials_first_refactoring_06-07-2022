class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

def add_pay (response, current_user_id)
  Pay.create(
    user_id:current_user_id,
    pay_id:response["id"],
    amount:response["amount"]["value"].slice(0..-3).to_i,
    status:'pending',
    handled:false
  )
end
  
def define_category(params)
  current_category_id = ''

  is_new_category = (Category.all.map(&:name).include?(params[:result_category_name])) ? false : true ; 

  if (is_new_category)
    target = params[:result_category_name]
    active_cat1 = params[:categoty_level1_cklicked]
    active_cat2 = params[:categoty_level2_cklicked]
    active_cat3 = params[:categoty_level3_cklicked]
    level1_exist = Category.find_by(name:active_cat1)
    level2_exist = Category.find_by(name:active_cat2)

    if (target == active_cat1)
      level1 = Category.create(name:active_cat1, parent_id:nil)
      current_category_id = level1.id
    else 
      if !level1_exist
      level1 = Category.create(name:active_cat1, parent_id:nil)      
        if (target == active_cat2)   
          level2 = Category.create(name:active_cat2, parent_id:level1.id)
          current_category_id = level2.id
        else
          if !level2_exist
            level2 = Category.create(name:active_cat2, parent_id:level1.id)
            level3 = Category.create(name:active_cat3, parent_id:level2.id)
            current_category_id = level3.id
          else
            level3 = Category.create(name:active_cat3, parent_id:level2_exist.id)
            current_category_id = level3.id
          end
        end 
      else
        if (target == active_cat2)
          level2 = Category.create(name:active_cat2, parent_id:level1_exist.id)
          current_category_id = level2.id
        else
          if !level2_exist
            level2 = Category.create(name:active_cat2, parent_id:level1_exist.id)
            level3 = Category.create(name:active_cat3, parent_id:level2.id)
            current_category_id = level3.id
          else
            level3 = Category.create(name:active_cat3, parent_id:level2_exist.id)
            current_category_id = level3.id
          end
        end
      end
    end
  else 
    current_category_id = Category.find_by(name:params[:result_category_name]).id
  end

  if (params[:result_category_name] == '')
    current_category_id = 0
  end
  return current_category_id
end



def user_for_mat(params)
  cur_user = User.find_by(company:params[:material][:company])
  user_id = 18 

  if cur_user ; user_id = cur_user.id; end
  return user_id
end

def requests_by_custumer(custumer_id)
  return User.find(custumer_id).requests
end