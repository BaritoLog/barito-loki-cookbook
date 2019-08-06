# Inspec test for recipe barito-loki::loki

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe group('barito_loki') do
    it { should exist }
  end

  describe user('barito_loki') do
    it { should exist }
  end
end

describe directory('/opt') do
  its('mode') { should cmp '0755' }
end

describe directory('/opt/bin') do
  its('mode') { should cmp '0755' }
end

describe directory('/var/cache/chef') do
  its('mode') { should cmp '0755' }
end

describe file('/opt/bin/loki') do
  its('mode') { should cmp '0755' }
end

describe file('/etc/default/loki-config.yml') do
  its('mode') { should cmp '0644' }
end

describe systemd_service('loki') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/opt/bin/promtail') do
  its('mode') { should cmp '0755' }
end

describe file('/etc/default/promtail-config.yml') do
  its('mode') { should cmp '0644' }
end

describe systemd_service('promtail') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
