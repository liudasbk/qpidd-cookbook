
qpid_service 'default' do
  action [:create, :start]
end

qpid_service 'second' do
  port '5673'
  interface '127.0.0.1'
  variables({ 'tcp-nodelay' => true, 'auth' => true, 'max-connections' => 100 })
  action [:create, :start]
end
