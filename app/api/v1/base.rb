module V1
  class Base < Grape::API
    version 'v1', :using => :path

    #  无需认证
    mount V1::Public::Base

    rescue_from :all, backtrace: true
    format :json

    before do
      error!({result: -1, message: '无效或者过期的授权'}, 401) unless authenticated
    end

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        true
        # pp params[:api_key]
        # params[:api_key] && @user = User.find_by_address(params[:api_key])
      end

      def current_user
        @user
      end
    end


    mount V1::Admin::Base
    
    add_swagger_documentation(
      :api_version => "api/v1",
      hide_documentation_path: true,
      hide_format: true
      )
  end
end