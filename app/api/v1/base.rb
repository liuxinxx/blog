module V1
  class Base < Grape::API
    version 'v1', :using => :path

    mount V1::ArticlesApi

    rescue_from :all, backtrace: true
    # error_formatter :json, API::ErrorFormatter
    format :json

    before do
      error!({result: -1, message: '无效或者过期的授权'}, 401) unless authenticated
    end

    helpers do
      def warden
        env['warden']
      end

      def authenticated
        params[:api_key] && @user = User.find_by_address(params[:api_key])
      end

      def current_user
        @user
      end
    end

    add_swagger_documentation(
      :api_version => "api/v1",
      hide_documentation_path: true,
      hide_format: true
      )
  end
end