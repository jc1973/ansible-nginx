describe command('curl localhost') do
  its('stdout') { should match /elcome/ }
  its('stdout') { should match /fizzbuck/ }
end

describe port(80) do
  it { should be_listening }
  #its('processes') {should include 'syslog'}
end
