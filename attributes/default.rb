# 
# Code to discover the location of the Ip Address
#

require 'net/http'
require 'json'

uri = URI("http://whatismyip.akamai.com/")
res = Net::HTTP.get_response(uri)
ip_address = res.body if res.is_a?(Net::HTTPSuccess)

uri = URI("http://ipinfo.io/#{ip_address}/json")
res = Net::HTTP.get_response(uri)

default["location"] = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)

case node["platform"]
when "ubuntu"
	default["apache"]["package_name"] = "apache2"
	default["apache"]["service_name"] = "apache2"
	default["apache"]["document_root"] = "/var/www"
	default["apache"]["conf_dir"] = "/etc/apache2/conf.d"
	default["apache"]["welcome_conf"] = "/etc/apache2/sites-enabled/000-default"
when "centos"
	default["apache"]["package_name"] = "httpd"
	default["apache"]["service_name"] = "httpd"
	default["apache"]["document_root"] = "/var/www/html"
	default["apache"]["conf_dir"] = "/etc/httpd/conf.d"
	default["apache"]["welcome_conf"] = "/etc/httpd/conf.d/welcome.conf"
end

default["apache"]["company"] = "Chef &amp Flexiant" 

default["apache"]["sites"]["chef"] = { 
	"port" => 80,
	"image_url" => "https://www.chef.io/images/logo.svg",
	"lb_url" => "chef.webinar.concerto.io"
}
default["apache"]["sites"]["flexiant"] = { 
	"port" => 80,
	"image_url" => "http://www.flexiant.com/wp-content/themes/flexiantv4/img/flexiant-logo.png",
	"lb_url" => "flexiant.webinar.concerto.io"
}
