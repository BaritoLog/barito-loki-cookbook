# Inspec test for recipe barito-loki::grafana

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

describe systemd_service('grafana-server') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
