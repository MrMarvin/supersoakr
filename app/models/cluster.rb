class Cluster
  include ActiveModel::Model
  attr_accessor :state

  def initialize(state = {})
    @state = state
  end

  def hostsfile
    get_tf_output('hostsfile')
  end

  def get_tf_output(output_name)
    (@state.fetch('modules')&.select {|e| e['path'].first == 'root' and e['path'].size == 1 }).first&.dig('outputs', output_name, 'value')
  end

  def version
    Rails.cache.fetch("clusters/#{get_tf_output('prefix')}", expires_in: 1.hours) do
      begin
        uri = URI.parse("https://#{get_tf_output('prefix')}.testing.mesosphe.re/dcos-metadata/dcos-version.json")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.port == 443)
        http.open_timeout = 2
        http.read_timeout = 2
        Rails.logger.info("updating cluster version from #{uri.to_s}")
        res = http.request(Net::HTTP::Get.new(uri.request_uri))

        JSON.parse(res.body)

      rescue StandardError
        {'version' => '0.0.0', 'dcos-image-commit' => '???'}
      end
    end
  end
end
