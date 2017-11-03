describe port(80) do
  it { should be_listening }
  #its('processes') {should include 'syslog'}
end
