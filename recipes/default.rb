#
# Cookbook Name:: pkgsrc
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# http://wiki.joyent.com/display/jpc2/Building+your+Own+Packages

# pkgin in scmgit-base gcc47

packages = %w{
 scmgit-base
 gcc47
 url2pkg
 pgklint
}

packages.each do |pkg|
  package pkg do
    action :install
  end
end

git "/opt/pkgsrc" do
  repository "git://github.com/joyent/pkgsrc.git"
  action :sync
end

bash "setup pkgsrc submodules" do
  user "root"
  cwd "/opt/pkgsrc"
  code <<-EOH
  git submodule init
  git submodule update
  EOH
end

bash "clone pk framework and add to PATH" do
  user "root"
  cwd "/opt"
  code <<-EOH
  git clone -b pkgsrc_2012Q1 git://github.com/mamash/pk.git
  sed -i'' '\,^PATH,s,$,:/opt/pk/bin,' ~/.profile && source ~/.profile
  EOH
end