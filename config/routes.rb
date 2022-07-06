Rails.application.routes.draw do

  # есть views
  root 'a1_items#show'
  resources :a1_items
# кабинет продавца 
    # продавец
    get 'a2_sellers/main'
    get "a2_sellers/requests"
    # модератор
    get "/mod/seller/cabinet/main/:seller_id"       ,to: "a2_sellers#main"
    get "/mod/seller/cabinet/requests/:seller_id"   ,to: "a2_sellers#requests"

# кабинет покупателя
    # покупатель
    get 'a3_custumers/main'
    get 'a3_custumers/history'
    # модератор
    get "/mod/custumer/cabinet/main/:custumer_id"   ,to: "a3_custumers#main"
    get "/mod/custumer/cabinet/history/:custumer_id"   ,to: "a3_custumers#history"

# кабинет модератора/администратора
    # модератор 
    get 'mod/sellers'            ,to: 'a4_moderators#mod1_sellers'
    get 'mod/custumers'          ,to: 'a4_moderators#mod2_custumers'
    get 'mod/moderate'           ,to: 'a4_moderators#mod3_moderate'
    # администратор
    get 'mod/config'             ,to: 'a4_moderators#mod4_config'

# манипуляция с users со стороны модератора/администратора
    get   "mod/edit/user/:id"    ,to: "a4_moderators#edit_user"   ,as: "mod_edit_user"
    patch "mod/update/user/:id"  ,to: "a4_moderators#update_user" ,as: "mod_update_user"

 

    
  

# нет views
  get "/mod/material/to/active/:mat_id/:current_user_id", to: "fetch_requests#mat_active"
  get "/mod/material/to/delete/:mat_id/:current_user_id", to: "fetch_requests#mat_delete"
  get "/to_moderate/:mat_id", to:"a2_sellers#to_moderate"
  get "/mat/to/delete/:mat_id", to: "a2_sellers#mat_delete"


  get "/get_all_materials"   , to: 'fetch_requests#get_all_materials'
  get "/get_all_categories"  , to: "fetch_requests#get_all_categories"
  get "/update_purse"        , to: "fetch_requests#update_purse"

  get "/delete/user/:id"     ,to: "fetch_requests#delete_user", as: "delete_user"
  get 'requests/add/:user_id/:material_id'    , to: "fetch_requests#request_add"
  post "/baskets/to_archive",              to: "fetch_requests#to_archive"
  post "/baskets/to_archive/:user_id",              to: "fetch_requests#to_archive"
  post "/baskets/to_delete/from/:custumer_id",         to: "fetch_requests#request_delete"

  patch "/config/yookassa"   ,to: "fetch_requests#yookassa"
  post "/config/create_mod", to: "fetch_requests#create_mod", as: "config_create_mod"
  post '/pay' , to: "a1_items#index"

#######################################################################

  
   get 'baskets/delete/:user_id/:material_id'    , to: "requests#delete"


  get "/admins/create/mes/:to_user_id/:from_user_id/:body", to: "admins#create_mes", as: "admins_create_mes"
  get "admins/admin"
 
  get "/in_seller_cabinet_from_admin_to_requests/:user_id", to: "sellers#requests"
  get "/in_custumer_cabinet_from_admin/:user_id", to: "custumers#index"
  get "/in_custumer_cabinet_from_admin_to_history/:user_id", to: "custumers#history"


  get "moderating/material/edit/:mat_id/:current_user_id", to: "admins#mat_edit"


  get "/sellers/requests/:id", to: "sellers#delete", as: "sellers/req/del"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get "/users", to: "categories#index"

  post "/materials/new", to: "materials#create"
  
  # get "/publish_material/:id", to:"sellers#publish", as: "publish_material"


 
  # для редиректа при апдейте профиля

  get 'sign_out_reg/:workgroupe', as: "sign_out_reg_cabinet", to: "sellers#index"


  
end
