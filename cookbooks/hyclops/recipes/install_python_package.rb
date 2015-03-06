ohai = Ohai::System.new
ohai.all_plugins

pypkgs = %w[zabbix-api pyzmq psphere configobj boto]

if ohai[:languages][:python][:version] =~ /^2\.6\..*/ then
  pypkgs.concat(%w[ordereddict argparse])
end


# execute 'pip install --upgrade setuptools' do
#   action :run
# end

python_pip "setuptools" do
  action :install
  options "--upgrade"
end

pypkgs.each do |pypkg|
  python_pip pypkg do
    action :install
  end
end

python_pip "python-daemon" do
  version "1.6"
  action :install
end

python_pip 'apache-libcloud' do
  version '0.13.3'
  action :install
end
