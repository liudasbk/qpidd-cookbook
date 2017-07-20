
describe service('qpidd-default') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(5672) do
  it { should be_listening }
  its('processes') { should include 'qpidd' }
end

describe service('qpidd-second') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

if os[:family] == 'rhel' && os[:version].to_f >= 7.0
  describe port(5673) do
    it { should be_listening }
    its('processes') { should include 'qpidd' }
    its('addresses') { should include '127.0.0.1' }
  end
else
  describe port(5673) do
    it { should be_listening }
    its('processes') { should include 'qpidd' }
  end
end
