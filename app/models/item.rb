class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ShippingPayer

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ShippedFrom

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ArriveIn

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price, numericality: { only_integer: true },
      inclusion: { in: 300..9999999 }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_payer_id
    validates :shipped_from_id
    validates :arrive_in_id
  end
end
