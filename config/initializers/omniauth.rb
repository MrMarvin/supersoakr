Rails.application.config.middleware.use OmniAuth::Builder do
  provider :saml,
    :assertion_consumer_service_url     => "https://soak.mesosphere.com/sso/saml/callback",
    :issuer                             => "OneLogin",
    :idp_sso_target_url                 => "https://mesosphere.onelogin.com/trust/saml2/http-post/sso/846663",
    :idp_sso_target_url_runtime_params  => {:original_request_param => :mapped_idp_param},
    :idp_cert_fingerprint               => "83:ED:25:4F:C5:80:2D:3D:AE:52:67:C4:A4:90:2A:F1:0B:DC:3D:A5",
    :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
end
OmniAuth.config.path_prefix = '/sso'
