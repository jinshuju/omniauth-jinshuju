require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Jinshuju < OmniAuth::Strategies::OAuth2

      option :name, 'jinshuju'

      option :client_options, {
        site: 'https://api.jinshuju.net',
        authorize_url: '/oauth/authorize',
        token_url: '/oauth/token'
      }

      option :authorize_params, {scope: 'public forms read_entries write_entries'}
      option :token_params, {
        parse: :json
      }

      uid do
        raw_info['id']
      end

      info do
        {
          nickname: raw_info['nickname'],
          email: raw_info['email']
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('v4/me').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'jinshuju', 'Jinshuju'
