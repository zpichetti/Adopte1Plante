class Composition < ApplicationRecord
  has_many :orders
  has_many :ratings

  mount_uploader :photo, PhotoUploader

  def findphoto
    hash_sku = { variant_plant_sku: "dfdsf" }
    search_composition = Composition.all.select do |comp|
      (comp.variant_plant_sku == hash_sku[:variant_plant_sku]) && (comp.variant_pot_sku == hash_sku[:variant_pot_sku])
    end
    good_composition = search_composition&.first
    return good_composition.local_image unless good_composition.nil?
  end

  def price
    price = 0
    variants = self.variants_match.split(";")
    variants.each do |variant|
      price += Variant.find(variant.to_i).price_cents
    end
    price
  end
end
