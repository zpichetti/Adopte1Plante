class VariantPlant < ApplicationRecord
  belongs_to :plant
  validates :sku, presence: true, uniqueness: true
  validates :diameter_cm, presence: true
  validates :height_format, presence: true, inclusion: { in: %w(S M L)}

  def findphoto
    search_composition = Composition.all.select do |comp|
      (comp.variant_plant_sku == self.sku) && (comp.variant_pot_sku.nil?)
    end
    good_composition = search_composition&.first

    if good_composition.nil?
      return "variants_plant/default.png"
    else
      return good_composition.local_image
    end
  end

  def findcompositionforplantvariant
    search_composition = Composition.all.select do |comp|
      (comp.variant_plant_sku == self.sku) && (comp.variant_pot_sku.nil?)
    end
    good_composition = search_composition&.first
  end
end

