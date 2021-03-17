# テーブル設計

## users テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| nickname   | string  | null: false |
| email      | string  | null: false |
| password   | string  | null: false |
| last_name  | string  | null: false |
| first_name | string  | null: false |
| last_kana  | string  | null: false |
| first_kana | string  | null: false |
| year_id    | integer | null: false |
| month_id   | integer | null: false |
| day_id     | integer | null: false |

### Association

- has_many :products
- has_many :purchase_records

## products テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| product_name         | text       | null: false                    |
| product_introduction | text       | null: false                    |
| product_category_id  | integer    | null: false                    |
| product_condition_id | integer    | null: false                    |
| shipping_payer_id    | integer    | null: false                    |
| shipped_from_id      | integer    | null: false                    |
| arrive_in_id         | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_records テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user                 | references | null: false, foreign_key: true |
| product              | references | null: false, foreign_key: true |

### Association

- belongs_to :product
- belongs_to :user
- has_one :shipping_information

## shipping_information テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record