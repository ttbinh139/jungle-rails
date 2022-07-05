require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'create new user successfully' do
      @user = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save!
  
      expect(@user.firstname).to be_present
      expect(@user.lastname).to be_present
      expect(@user.email).to be_present
      expect(@user.password_digest).to be_present
    end
  
    it 'create new user unsuccessfull because password and password_confirmation not match' do
      @user = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "12345"
      )
      @user.save
  
      expect(@user.errors.full_messages).to be_present
      expect(@user.errors.full_messages[0]).to eql("Password confirmation doesn't match Password")
    end
  
    it 'create new user unsuccessfull because email is not unique' do
      @user1 = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user1.save!
  
      @user2 = User.new(
        firstname: "Binh 2", 
        lastname: "Trinh 2", 
        email: "admin@binhtt.com", 
        password: "12345", 
        password_confirmation: "12345"
      )
      @user2.save

  
      expect(@user2.errors.full_messages).to be_present
      expect(@user2.errors.full_messages[0]).to eql("Email has already been taken")
    end
  
    it 'create new user unsuccessfull email is nil' do
      @user = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        #email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save
  
      expect(@user.errors.full_messages).to be_present
      expect(@user.errors.full_messages[0]).to eql("Email can't be blank")
    end
  
    it 'create new user unsuccessfull first name is nil' do
      @user = User.new(
        #firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save
  
      expect(@user.errors.full_messages).to be_present
      expect(@user.errors.full_messages[0]).to eql("Firstname can't be blank")
    end
  
    it 'create new user unsuccessfull last name is nil' do
      @user = User.new(
        firstname: "Binh", 
        #lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save
  
      expect(@user.errors.full_messages).to be_present
      expect(@user.errors.full_messages[0]).to eql("Lastname can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should login if email and password matched' do
      @user = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save!
  
      @authenticatedUser = User.authenticate_with_credentials("admin@binhtt.com", "1234");
      expect(@authenticatedUser).to eq(@user) 
    end
  
    it 'should fail to login if password not matched' do
      @user = User.new(
        firstname: "Binh", 
        lastname: "Trinh", 
        email: "admin@binhtt.com", 
        password: "1234", 
        password_confirmation: "1234"
      )
      @user.save!
  
      @authenticatedUser = User.authenticate_with_credentials("admin@binhtt.com", "12345");
      expect(@authenticatedUser).to be_nil
    end
  end

end
