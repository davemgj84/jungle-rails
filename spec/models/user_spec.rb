require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'Validates a new user' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      expect(@new_user).to be_valid
    end

    it 'Does not validate when the password and the password confirmation fields do not match' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345679")
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it 'Requires emails to be unique (not case sensitive)' do
      @new_user1 = User.new(first_name: "David", last_name: "Jardine", email: "test@test.com", password: "12345678", password_confirmation: "12345678")
      @new_user1.save
      @new_user2 = User.new(first_name: "Matthew", last_name: "Jardine", email: "TEST@TEST.com", password: "12345678", password_confirmation: "12345678")
      @new_user2.save
      expect(@new_user2).to_not be_valid
    end

    it 'Will not validate user without a first name' do
      @new_user = User.new(first_name: nil, last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it 'Will not validate user without a last name' do
      @new_user = User.new(first_name: "David", last_name: nil, email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it 'Will not validate user without an email' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: nil, password: "12345678", password_confirmation: "12345678")
      @new_user.save
      expect(@new_user).to_not be_valid
    end

    it 'Will not validate user when password is less than 8 characters ' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "1234567", password_confirmation: "1234567")
      @new_user.save
      expect(@new_user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    it 'Authenticates credentials with correct email and password' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      @authenticate = User.authenticate_with_credentials("1@mail.com", "12345678")
      expect(@authenticate).to eql(@new_user)
    end

    it 'Does not authenticate with incorrect password' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      @authenticate = User.authenticate_with_credentials("1@mail.com", "12345")
      expect(@authenticate).to be_nil
    end

    it 'Does not authenticate with incorrect email' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      @authenticate = User.authenticate_with_credentials("2@mail.com", "12345678")
      expect(@authenticate).to be_nil
    end

    it 'Authenticates email ignoring the whitespace before or after' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "1@mail.com", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      @authenticate = User.authenticate_with_credentials("    1@mail.com    ", "12345678")
      expect(@authenticate).to eql(@new_user)
    end

    it 'Authenticates email regardless of case' do
      @new_user = User.new(first_name: "David", last_name: "Jardine", email: "eXample@domain.COM", password: "12345678", password_confirmation: "12345678")
      @new_user.save
      @authenticate = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "12345678")
      expect(@authenticate).to eql(@new_user)
    end

  end

end
