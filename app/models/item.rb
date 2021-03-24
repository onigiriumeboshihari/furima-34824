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
    validates :name
    validates :introduction
    validates :category_id
    validates :condition_id
    validates :shipping_payer_id
    validates :shipped_from_id
    validates :arrive_in_id

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :shipping_payer_id
      validates :shipped_from_id
      validates :arrive_in_id
    end

    validates :price, numericality: { only_integer: true },
    numericality: { greater_than_or_equal_to: 300 },
    numericality: { less_than_or_equal_to: 9999999 }
  end
end
