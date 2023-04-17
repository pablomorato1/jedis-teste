class CitizensController < ApplicationController
  before_action :collection, only: :index
  before_action :config_fields
  before_action :citizen, only: [:new, :create, :edit, :update]

  def index
  end

  def new
    @citizen.build_address
  end

  def edit
  end

  def create
    if @citizen.valid?
      @citizen.save!
      flash[:info] = 'Criado com sucesso!'
      # send_notification
      redirect_to root_path
    else
      flash[:error] = 'Erro ao salvar. Tente novamente!'
      redirect_to new_citizen_path(citizen: object_params, render_errors: true)
    end
  end

  def update
    if @citizen.update(object_params)
      redirect_to root_path
    else
      redirect_to action: :edit
    end
  end

  private

  def config_fields
    @config = {
      model: :citizen,
      index_actions: [:edit],
    }
  end

  def config_model
    Citizen
  end

  def object_params
    params.fetch(:citizen, {}).permit(:full_name, :cpf, :cns, :email, :birth_date, :phone_number, :picture,
                  :active, address_attributes: %i[id cep street neighborhood city state complement ibge])
  end

  def citizen
    @citizen ||= params[:id].present? ? config_model.find(params[:id]) : config_model.new(object_params)
  end
end
