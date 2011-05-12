require 'diesel/generators/install_base'

module SimpleAuth
  module Generators
    class InstallGenerator < Diesel::Generators::InstallBase
      def install
        %w(sessions).each do |controller|
          template "#{controller}_controller", "app/controllers/#{controller}_controller.rb"
        end
      end
    end
  end
end
