#
# Cookbook:: rediscluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
include_recipe 'redis::install_from_package'
include_recipe 'install_from'

instance = search('aws_opsworks_instance', "self:true").first
Chef::Log.info("********** The instance's public ip is '#{instance['public_ip']}' **********")

install_from_release('rediscluster') do
  release_url  node[:rediscluster][:release_url]
  home_dir     node[:rediscluster][:home_dir]
  version      node[:rediscluster][:version]
  action       :build_with_make
  not_if{ File.exists?(File.join(node[:rediscluster][:home_dir], 'redis-server')) }
end

package 'ruby' do
  action :install
end

bash 'install redis gem' do
  code <<-EOH
  gem install redis
  EOH
  action :run
end

service 'redis-server' do
  action :stop
end

template '/etc/redis/redis.conf' do
  source 'redistemplate.conf.erb'
  variables 'public_ip' => instance['public_ip']
  action :create
end

service 'redis-server' do
  action :restart
end
