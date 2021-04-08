# class User < ApplicationRecord÷::Base 
class User < ApplicationRecord 
    has_secure_password
    has_many :todos
end