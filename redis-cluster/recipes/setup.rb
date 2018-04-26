#
# Cookbook:: redis-cluster
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/cheftemp' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

file '/cheftemp/testfile' do
  content 'testcontent'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
