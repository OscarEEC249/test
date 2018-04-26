#
# Cookbook:: redis-cluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'redis::install_from_package'

execute 'apache_configtest' do
    command 'redis-server'
  end