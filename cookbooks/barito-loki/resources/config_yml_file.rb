property :file, String, name_property: true
property :config, Hash, required: true
property :user, String, required: true
property :group, String, required: true

action :create do
  template new_resource.file do
    source 'config.yml.erb'
    owner new_resource.user
    group new_resource.group
    mode 0o600
    variables config: YAML.dump(new_resource.config.to_hash)
  end
end
