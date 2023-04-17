class ApplicationController < ActionController::Base
  private

  def collection
    @q = config_model.ransack(search_params)
    @qr = @q.result(distinct: true)
    @collection = @qr.paginate(:page => params[:page], :per_page => 30)
  end

  def search_params
    params[:q].nil? ? session["search_#{controller_name}"] : session["search_#{controller_name}"] = params[:q]
  end
end
