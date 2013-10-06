class Country < ActiveRecord::Base
  attr_accessible :id, :name, :iso2, :iso3, :phone_code, :locale
  validates_presence_of :name,
                        :iso2,
                        :iso3
  has_many :states
end
