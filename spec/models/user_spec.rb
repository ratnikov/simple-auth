require 'spec_helper'

class User < ActiveRecord::Base
  include SimpleAuth::User
end

describe User do
  describe "when a user is saved" do
    before(:each) { @user = User.new(:password => 'secret'); @user.save! }

    it "should authenticate with correct password" do
      User.find(@user).authenticated?('secret').should be_true
    end

    it "should not authenticate with wrong password" do
      User.find(@user).authenticated?('bad-password').should be_false

      User.find(@user).authenticated?(nil).should be_false
      User.find(@user).authenticated?('').should be_false
    end
  end

  it "should not allow mass-assigning sensitive fields" do
    user = User.new :encrypted_password => 'foo', :salt => 'bar'

    user.encrypted_password.should be_nil
    user.salt.should be_nil
  end

  it "should provide different encryptions for same passwords" do
    (bob = User.new :password => 'foo').save!
    (joe = User.new :password => 'foo').save!

    bob.encrypted_password.should_not == joe.encrypted_password
  end
end
