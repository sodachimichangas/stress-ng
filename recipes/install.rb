#
# Cookbook Name:: stress_ng
# Recipe:: install
#

# Copyright (C) 2016 Ivan Yuja 
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

include_recipe 'build-essential::default'

app_dir = '/tmp/stress-ng-build'

git app_dir do
  repository node['stress-ng']['repo']['url']
  revision node['stress-ng']['repo']['revision']
  notifies :run, 'execute[make]', :immediate
  action :sync
end

execute "make" do
  cwd app_dir 
  action :nothing
  notifies :run, 'execute[make_install]', :immediate
end

execute "make_install" do
  command "make install"
  cwd app_dir
  action :nothing
end
