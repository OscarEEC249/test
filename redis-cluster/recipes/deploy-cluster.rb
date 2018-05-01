instances = search('aws_opsworks_instance')
port = 6379

if instances.count == 6
  Chef::Log.info("********** Setting up cluster: '#{instances.count}' **********")
  ips_segment = ''
  instances.each do |instance|
    ips_segment.concat("#{instance['public_ip']}:#{port} ")
  end
  ips_segment.chomp(' ')
  setup_cmd = '/usr/local/share/redis/src/redis-trib.rb create --replicas 1 '
  setup_cmd.concat(ips_segment)

  # current_instance = search('aws_opsworks_instance', 'instance', 'hostname').first
  # current_instance = node["opsworks"]["instance"]["layers"][0]
  current_instance = search('aws_opsworks_instance', 'self:true').first
  Chef::Log.info("Value of current_instance '#{current_instance['hostname']}'")

  if current_instance['hostname'] == 'test1'
    Chef::Log.info("********** Command to execute: '#{setup_cmd}' **********")
    bash 'deploy-cluster' do
      code <<-EOH
      echo yes | #{setup_cmd}
      EOH
      action :run
    end

  end
else
  Chef::Log.info("********** Not enough nodes to setup a cluster. Nodes count: '#{instances.count}' **********")
end
