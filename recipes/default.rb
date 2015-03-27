#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# chef-repo/cookbooks/apache/recipes/default.rb

# install apache
package node["apache"]["package_name"] do
	action :install
end

# backup the default welcome page or delete the symlink
if node['platform'] == "centos"
  execute "mv #{node["apache"]["welcome_conf"]} #{node["apache"]["welcome_conf"]}.bak" do
    only_if do
      File.exist?("#{node["apache"]["welcome_conf"]}")
    end
    notifies :restart, "service[#{node["apache"]["service_name"]}]" 
  end
else
  link "#{node["apache"]["welcome_conf"]}" do
    action :delete
  end
end

#create the virtual host for each web site
node['apache']['sites'].each do |site_name, site_data|

  #define the document root for the web site
  document_root = "#{node["apache"]["document_root"]}/#{site_name}"
 
  #generate the site virtual host configuration
  template "#{node["apache"]["conf_dir"]}/#{site_name.downcase}.conf" do
    source "custom.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => site_data['port'],
      :alias => site_data['lb_url']
    )
    notifies :restart, "service[#{node["apache"]["service_name"]}]" 
  end
 
  # create the document root directory
  directory document_root do
    mode "0755"
    recursive true
  end
 
  # create the home page.
  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode "0644"
    variables(
      :site_name => site_name
    )
  end
end

# start apache service
# make sure the apache service starts on reboot
service node["apache"]["service_name"] do
	action [ :enable, :start ]
end
