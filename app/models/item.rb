class Item < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :condition

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :ShippingPayer

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :shipped_from_id

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :arrive_in_id


  with_options presence: true do
    validates :name
    validates :introduction
    validates :category_id
    validates :condition_id
    validates :shipping_payer_id
    validates :shipped_from_id
    validates :arrive_in_id
    validates :price, numericality: { only_integer: true, message: '半角数字を使用してください'
      ,greater_than_or_equal_to 300: true, message: '300から9,999,999までの金額をご入力ください'
      ,less_than_or_equal_to 9999999: true, message: '300から9,999,999までの金額をご入力ください' }
      #, inclusion: { in: 300..99999999999,  }
  end

  
end
