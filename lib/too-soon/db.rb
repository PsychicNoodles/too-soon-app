require 'sequel' # http://sequel.jeremyevans.net/rdoc/files/doc/cheat_sheet_rdoc.html
require 'sequel_secure_password'

DB = Sequel.sqlite # in-memory database, change later
DB.create_table :votes do
  primary_key :id
  DateTime :datetime
  foreign_key :topic_id, :topics
  foreign_key :user_id, :users
  TrueClass :vote, :null => false # boolean type
end

class Vote < Sequel::Model
  plugin :timestamps, :create => :datetime
  many_to_one :topic
  many_to_one :user
  many_to_many :modifiers
end

DB.create_table :modifiers_votes do
  primary_key :id
  foreign_key :vote_id, :votes
  foreign_key :modifier_id, :modifiers
end

DB.create_table :users do
  primary_key :id
  String :username, :null => false, :unique => true
  String :email, :null => false, :unique => true
  String :password_digest, :null => false
  String :twitter_id # if linked to Twitter
end

class User < Sequel::Model
  plugin :secure_password # https://github.com/mlen/sequel_secure_password
  one_to_many :votes
end

DB.create_table :topics do
  primary_key :id
  String :name
end

class Topic < Sequel::Model
  one_to_many :modifiers
end

DB.create_table :modifiers do
  primary_key :id
  String :name
  foreign_key :topic_id, :topics
end

class Modifier < Sequel::Model
  many_to_one :topic
  many_to_many :votes
end
