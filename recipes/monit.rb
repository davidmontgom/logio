

service "monit"
template "/etc/monit/conf.d/logio.conf" do
  path "/etc/monit/conf.d/logio.conf"
  source "monit.conf.erb"
  owner "root"
  group "root"
  mode "0755"
  #variables :role_list => role_list
  notifies :restart, resources(:service => "monit")
end