# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## usersテーブル

| Column         | Type    | Options                   |
| -------------- | ------- | ------------------------- |
| nickname       | string  | null: false               |
| email          | string  | null: false, unique: true |
| password       | string  | null: false               |
| last_name      | string  | null: false               |
| first_name     | string  | null: false               |
| last_furigana  | string  | null: false               |
| first_furigana | string  | null: false               |
| birthday       | integer | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## itemsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| price           | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| rank_id         | integer    | null: false                    |
| delivery_fee    | integer    | null: false                    |
| delivery_source | integer    | null: false                    |
| delivery_days   | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

## purchase_recordsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
_ belongs_to :item
- has_one :buyer_address

### buyer_addressesテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture      | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| phone_number    | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record