class Category < ActiveRecord::Base
  attr_accessible :description, :order, :title, :translations_attributes, :site_position
  has_many :draws

  translates :title, :description
  accepts_nested_attributes_for :translations
  class Translation
    attr_accessible :locale, :title, :description
  end
  def translations_attributes=(attributes)
    new_translations = attributes.values.reduce({}) do |new_values, translation|
      new_values.merge! translation.delete("locale") => translation
    end
      set_translations new_translations
  end  
  
end
