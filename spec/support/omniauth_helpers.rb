# frozen_string_literal: true

module OmniAuthHelpers
  def omniauth_user(service = :twitter)
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[service] = OmniAuth::AuthHash.new(
      provider: service.to_s,
      uid: '1234',
      info: {
        name: 'mockuser',
        image: 'https://placehold.jp/150x150.png'
      }
    )
  end
end
