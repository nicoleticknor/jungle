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
      it 'is invalid if created without a last_name' do
        user = User.new(:first_name => nil, :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
    end

    context 'email validations' do
      before do
        user2 = User.create(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
      end

      it 'is invalid if created without an email' do
        user = User.new(:first_name => "Harry", :last_name => "Manback", :email => nil, :password => "testing", :password_confirmation => "testing")
        expect(user).to_not be_valid
      end
      
      it "is invalid if created without a unique email" do
          user1 = User.new(:first_name => "Harry", :last_name => "Manback", :email => "testing@email.com", :password => "testing", :password_confirmation => "testing")
          expect(user1).to_not be_valid
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

  # describe '.authenticate_with_credentials' do
  # end
end
