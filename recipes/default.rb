

bash "nodejs_log-io" do
    user "ubuntu"
    code <<-EOH
      sudo npm install -g log.io --user "ubuntu"
      touch /var/chef/cache/logio.lock
    EOH
    action :run
    not_if {File.exists?("/var/chef/cache/logio.lock")}
end

=begin
/usr/bin/log.io-harvester
/usr/lib/node_modules/log.io/bin/log.io-harvester


/usr/bin/log.io-server
/usr/lib/node_modules/log.io/bin/log.io-server

=end

=begin
include_recipe "runit"
runit_service "ioharvester"
runit_service "ioserver"


execute "restart_harvester" do
  command "sudo supervisorctl restart harvester_server:"
  action :nothing
end
execute "restart_io-server" do
  command "sudo supervisorctl restart io-server_server:"
  action :nothing
end

template "/etc/supervisor/conf.d/io-server.conf" do
  path "/etc/supervisor/conf.d/io-server.conf"
  source "supervisord.io-server.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :run, "execute[restart_io-server]"
end

template "/etc/supervisor/conf.d/io-harvester.conf" do
  path "/etc/supervisor/conf.d/io-harvester.conf"
  source "supervisord.io-harvester.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :run, "execute[restart_harvester]"
end

#/usr/lib/node_modules/log.io/conf/harvester.conf
template "/home/ubuntu/.log.io/harvester.conf" do
  path "/home/ubuntu/.log.io/harvester.conf"
  source "harvester.conf.erb"
  owner "ubuntu"
  group "ubuntu"
  mode "0755"
  notifies :run, "execute[restart_harvester]"
end
=end

=begin
uwsgi_port=28777
nginx_port=84

template "/etc/nginx/sites-available/logio.nginx.conf" do
  path "/etc/nginx/sites-available/logio.nginx.conf"
  source "logio.nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, resources(:service => "nginx")
  variables :nginx_port => nginx_port, :uwsgi_port => uwsgi_port
end

link "/etc/nginx/sites-enabled/logio.nginx.conf" do
  to "/etc/nginx/sites-available/logio.nginx.conf"
end
service "nginx"
=end


