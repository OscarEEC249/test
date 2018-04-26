#
# Cookbook:: redis-cluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'redis::install_from_package'

bash 'name' do
  code <<-EOH
  redis_server
  EOH
  action :run
end