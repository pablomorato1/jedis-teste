# frozen_string_literal: true

class Citizen < ApplicationRecord
  include Cns

  has_one :address, dependent: :destroy
  has_one_attached :picture
  accepts_nested_attributes_for :address

  validates :full_name, :cpf, :cns, :email, :birth_date, :phone_number, presence: true
  validates :cpf, :cns, :email, uniqueness: true
  validate :cpf_is_valid?, :email_is_valid?, :cns_is_valid?, :birth_date_valid?

  after_create :send_welcome
  after_update :send_welcome

  def cpf_is_valid?
    return errors.add(:cpf, 'CPF invalido') unless CPF.valid?(cpf)
  end

  def email_is_valid?
    return errors.add(:email, 'Email invalido') unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def cns_is_valid?
    return errors.add(:cns, 'CNS invalido') unless Cns.validate(cns)
  end

  def birth_date_valid?
    return errors.add(:birth_date, 'Preencha a data de nascimento') unless birth_date.present?
    date_time = birth_date.to_datetime
    year = date_time.year
    actual_year = DateTime.now.year

    return errors.add(:birth_date, 'Data de nascimento invalida') if year > actual_year || (actual_year - year) > 120
  end

  def send_welcome
    Thread.new do
      ApplicationMailer.welcome(self).deliver_now
      TwilioMessengerService.new('Cadastro realizado com sucesso! Jedis Team', phone_number).call
    end
  end
end
