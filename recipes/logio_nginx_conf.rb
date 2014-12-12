data_bag("my_data_bag")
db = data_bag_item("my_data_bag", "my")

datacenter = node.name.split('-')[0]
server_type = node.name.split('-')[1]
location = node.name.split('-')[2]

if location=='local'
  uwsgi_port=28777
  nginx_port=84
else
  uwsgi_port=28777
  nginx_port=84
end

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
