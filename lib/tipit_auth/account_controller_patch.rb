require_dependency 'account_controller'

module TipitAuth

  module AccountControllerPatch

    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      end

    end

    module ClassMethods
    end

    module InstanceMethods

      def oauth_login
        email = auth_hash.info.email
        user = User.find_by_mail(email)
        if (user.nil?)
          user = create_user_from_oauth_hash(auth_hash)
        end
        successful_authentication(user)
      end

      def create_user_from_oauth_hash(oauth_hash)
        user = User.new
        user.mail = auth_hash.info.email
        user.firstname = auth_hash.info.first_name
        user.lastname = auth_hash.info.last_name
        user.login = user.mail
        user.password = ActiveSupport::SecureRandom.hex(5)
        user.language = Setting.default_language
        user.save ? user : nil
      end


      def auth_hash
        request.env['omniauth.auth']
      end
    end

end