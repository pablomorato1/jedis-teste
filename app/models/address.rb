# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :citizen

  validates :cep, :street, :neighborhood, :city, :state, presence: true
end

