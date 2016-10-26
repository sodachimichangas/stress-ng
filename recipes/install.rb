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
