class ApiController < ApplicationController

  def certification_thickness
    @block = Block.with_shop_order(params[:shop_order]).where(include_on_certification: true).first
  end

end
