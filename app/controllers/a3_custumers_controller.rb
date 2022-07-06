class A3CustumersController < ApplicationController
  def main
    @materials = requests_by_custumer(params[:custumer_id] || current_user.id)
                  .select {|r| r[:custumer_side] == "basket"}
                  .map(&:material)
  end
    
    
  def history
    @archive = requests_by_custumer(params[:custumer_id] || current_user.id)
                  .select {|r| r[:custumer_side] == "archive"}
                  .map(&:material)
  end
end
