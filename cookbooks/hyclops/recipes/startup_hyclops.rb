%w[httpd zabbix-server].each do |s|
  service s do
    action :start
    supports(
      status:  true,
      restart: true,
      reload:  false
    )
  end
end

service 'hyclops' do
  action [:enable, :start]
  supports(
    status:  true,
    restart: true,
    reload:  false
  )
end
