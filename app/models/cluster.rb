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
    url = URI("https://#{get_tf_output('prefix')}.testing.mesosphe.re/dcos-metadata/dcos-version.json")
    @version ||= JSON.parse(Net::HTTP.get(url))
  end
end
