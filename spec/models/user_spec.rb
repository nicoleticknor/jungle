require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'add new user' do

    context 'adding valid new user' do
      it 'is valid if created with a first_name, last_name, email, password, and password_confirmation' do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
        expect(user).to be_valid
      end
    end

    context 'first_name validations' do
      it 'is invalid if created without a last_name' do
        user = User.new(:first_name => "Harry", :last_name => nil, :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
    end

    context 'last_name validations' do
      it 'is invalid if created without a first_name' do
        user = User.new(:first_name => nil, :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
    end

    context 'email validations' do
      before do
        user = User.create(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
      end

      it 'is invalid if created without an email' do
        user1 = User.new(:first_name => "Harry", :last_name => "Manback", :email => nil, :password => "testing", :password_confirmation => "testing")
        expect(user1).to_not be_valid
      end
      
      it "is invalid if created without a unique email" do
          user2 = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
          expect(user2).to_not be_valid
      end

      it "is invalid if created without a unique email that is case-sensitive" do
        user1 = User.new(:first_name => "Harry", :last_name => "Manback", :email => "TESTING@email.com", :password => "testing", :password_confirmation => "testing")
        expect(user1).to_not be_valid
      end
    end

    context 'password validations' do
      it 'is invalid if created without a password' do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => nil, :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
  
      it 'is invalid if created with a password with length less than 6' do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "test", :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
  
      it 'is invalid if created without a password_confirmation' do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => nil)
        expect(user).to_not be_valid
      end
  
      it "is invalid if password and password_confirmation don't match" do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "doesn't match")
        expect(user).to_not be_valid
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      user = User.create(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
    end

    context 'authenticating valid user' do
      it 'is returns the user object when the username and password are correct' do
        user = User.authenticate_with_credentials("testing@email.com", "testing")
        expect(user).to_not be_nil
      end

      it 'is returns the user object when the username and password are correct but username is entered with leading and trailing spaces' do
        user = User.authenticate_with_credentials("   testing@email.com   ", "testing")
        expect(user).to_not be_nil
      end

      it 'is returns the user object when the username and password are correct and username is not case sensitive' do
        user = User.authenticate_with_credentials("testiNg@Email.COm", "testing")
        expect(user).to_not be_nil
      end
    end

    context 'validations for email credential' do
      it 'returns nil if the user email is not in the database' do
        user = User.authenticate_with_credentials("notanemail@email.com", "testing")
        expect(user).to be_nil
      end
    end

    context 'validations for password credential' do
      it 'returns nil if the user password does not authenticate with the user.authenticate method' do
        user = User.authenticate_with_credentials("testing@email.com", "incorrectpassword")
        expect(user).to be_nil
      end
    end
  end
end
