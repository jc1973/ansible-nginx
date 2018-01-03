describe command('curl localhost:8080') do
  its('stdout') { should match /FAIL/ }
end

describe port(8080) do
  it { should be_listening }
end
