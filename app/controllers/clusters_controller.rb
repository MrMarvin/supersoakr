class ClustersController < ApplicationController

  def index
    bucket_name = URI.parse(ENV['S3_TERRAFORM_STATE_URL']).host
    bucket_prefix = URI.parse(ENV['S3_TERRAFORM_STATE_URL']).path[1..-1]
    s3 = Aws::S3::Client.new(region: 'us-east-1')

    @clusters = Rails.cache.fetch("clusters", expires_in: 1.hours) do
      @clusters = []
      state_files = s3.list_objects(bucket: bucket_name, prefix: bucket_prefix).contents.map {|k| k.key}
      state_files.delete(bucket_prefix)

      state_files.each do |state_file|
        @clusters << Cluster.new(JSON.parse(s3.get_object(bucket: bucket_name, key: state_file).body.read))
      end

      @clusters
    end
  end
end
