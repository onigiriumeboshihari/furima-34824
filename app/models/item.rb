class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :ShippingPayer
  belongs_to :ShippedFrom
  belongs_to :ArriveIn

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price, numericality: { only_integer: true },
                      inclusion: { in: 300..9_999_999 }
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_payer_id
    validates :shipped_from_id
    validates :arrive_in_id
  end
end
