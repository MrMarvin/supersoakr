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
      url = URI("https://#{get_tf_output('prefix')}.testing.mesosphe.re/dcos-metadata/dcos-version.json")
      JSON.parse(Net::HTTP.get(url, read_timeout: 5))
    end
  rescue StandardError
    return {'version' => '0.0.0', 'dcos-image-commit' => '???'}
  end
end
