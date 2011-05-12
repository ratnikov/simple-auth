require 'digest/sha1'

module SimpleAuth
  module User
    def self.included(base)
      base.class_eval do
        before_save :initialize_salt
        before_save :encrypt_password

        attr_protected :salt, :encrypted_password
      end
    end

    attr_accessor :password

    def authenticated?(password)
      encrypted_password == encrypt(password)
    end

    private

    def initialize_salt
      if salt.blank?
        self.salt = ActiveSupport::SecureRandom.hex(20)
      end
    end

    def encrypt_password
      if password.present?
        write_attribute :encrypted_password, encrypt(password)
      end
    end

    def encrypt(string)
      Digest::SHA1.hexdigest("--#{salt}--#{string}--")
    end
  end
end
