attrs = node.default['zabbix']['server']['lang_ja']
attrs['fontpath']       = '/usr/share/fonts/vlgothic/'
attrs['fontname']       = 'VL-PGothic-Regular'

mysql_attrs = node.default['mysql']['server']
mysql_attrs['character-set-server'] = 'utf8'
mysql_attrs['default-character-set'] = 'utf8'

%w[vlgothic-p-fonts vlgothic-fonts vlgothic-fonts-common].each do |p|
  package p do
    action :install
  end
end

template 'defines.inc.php' do
  path '/usr/share/zabbix/include/defines.inc.php'
end
