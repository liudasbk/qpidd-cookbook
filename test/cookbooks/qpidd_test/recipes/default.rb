
qpid_service 'default' do
  action [:create, :start]
end

qpid_service 'second' do
  port '5673'
  interface '127.0.0.1'
  variables({ 'auth' => true, 'max-connections' => 100 })
  action [:create, :start]
end

# qpid_service 'delete' do
#   port '5674'
#   action [:create, :delete]
# end
