class Room < ApplicationRecord

 # DM機能
 # 2人のユーザーが複数のメッセージ(message)を送る多対多の関係、
 has_many :messages, dependent: :destroy
 # UsersテーブルとRoomsテーブルは多対多の関係にあり、中間テーブルとしてEntriesテーブルを置く
 has_many :entries, dependent: :destroy

end