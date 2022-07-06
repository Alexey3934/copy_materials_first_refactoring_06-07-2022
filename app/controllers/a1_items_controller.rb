class A1ItemsController < ApplicationController
    def show
        if (user_signed_in? && current_user.workgroupe == "Покупатель")
          @requests_basket = User.find(current_user.id).requests
            .select {|i| i[:custumer_side] == "basket"}
            .map(&:material_id)
        end
    end

    def edit
      @material = Material.find(params[:id])
      @target_category = Category.find(@material[:category_id])
    end
  
    def update
      current_category_id = define_category(params)
      @material = Material.find(params[:id])
      if     @material.update(
        description: params[:material][:description],
        unit: params[:material][:unit],
        price_retail: params[:material][:price_retail].to_i,
        price_wholesale: params[:material][:price_wholesale].to_i,
        amount_wholesale: params[:material][:amount_wholesale].to_i,
        category_id:current_category_id,
        place: params[:material][:place],
        company: params[:material][:company],
        phone: params[:material][:phone],
        active: false,
        to_moderating: true
        )
        redirect_to root_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @material = Material.find(params[:id])
      @material.destroy
      redirect_to cabinets_index_path, status: :see_other
    end
  
    def new
      @material = Material.new
    end   
  
    def create
   
      current_category_id = define_category(params[:material])
      user_id = user_for_mat(params)
      
      @material  = Material.new(
        description: params[:material][:description],
        unit: params[:material][:unit],
        price_retail: params[:material][:price_retail],
        price_wholesale: params[:material][:price_wholesale],
        amount_wholesale: params[:material][:amount_wholesale],
        category_id:current_category_id,
        place: params[:material][:place],
        company: params[:material][:company], 
        user_id: user_id,
        phone: params[:material][:phone],
        active: false,
        to_moderating: true
      )
      # debugger
      if @material.save
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def index
      require 'net/http'

      amount = params[:amount] + ".00"
      uri = URI('https://api.yookassa.ru/v3/payments')
      key = "test_OovknISXXpCD3BtM3z-ZVr_1BU9OJYoesi8QmKAoais"
      shopId = "910379"
      return_url = "http://185.112.83.162/materials/new"
      # return_url =  new_material_path 

      body = {
        'amount': {
          'value': "#{amount}",
          'currency': 'RUB'
        },
        "capture": true,
        'payment_method_data': {
          'type': 'bank_card'
        },
        'confirmation': {
          'type': 'redirect',
          'return_url': return_url
        },
        'description': "Заказ №73"}
      
      req = Net::HTTP::Post.new(uri)
      req['Idempotence-Key'] = "Ключ идемпотентности#{rand()}"
      req['Content-Type'] = "application/json"
      req.basic_auth shopId, key
      req.body = body.to_json()
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
          http.request(req)
        }

      response = JSON.parse(res.body)
      not_signed_user = User.find(18)
      cur_user_id = (user_signed_in?) ? current_user.id : not_signed_user.id ; 
      add_pay(response, cur_user_id)

      @url_to_yookassa = response["confirmation"]["confirmation_url"]
    end
  
    private
      def material_params
        params.require(:material).permit(:description, :unit,
           :price_retail, :price_wholesale, :amount_wholesale,
            :category, :place, :company, :phone)
      end

end
