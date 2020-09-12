require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before do
      @user = User.create({
        first_name: 'test',
        last_name: 'test',
        email: 'test@test.com',
        password: 'testpass',
        password_confirmation: 'testpass',
      })
    end

    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without first_name, last_name' do
      @user.first_name = nil;
      @user.last_name = nil;

      expect(@user).to_not be_valid
    end
  end
end
