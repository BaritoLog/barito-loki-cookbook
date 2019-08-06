property :name, String, name_property: true
property :version, String, required: true
property :prefix_root, String, required: true
property :prefix_bin, String, required: true
property :prefix_temp, String, required: true
property :mirror_gz, String, required: true
property :user, String, required: true
property :group, String, required: true

action :create do
  # Create prefix directories
  [
    new_resource.prefix_root,
    new_resource.prefix_bin,
    new_resource.prefix_temp
  ].uniq.each do |dir_path|
    directory "#{cookbook_name}:#{dir_path}" do
      path dir_path
      mode 0o755
      recursive true
      action :create
    end
  end

  # Put it into temporary directory first
  temp_bin = "#{new_resource.prefix_temp}/#{new_resource.name}-#{new_resource.version}"
  remote_file "#{temp_bin}.gz" do
    source new_resource.mirror_gz
    owner new_resource.user
    group new_resource.group
    mode 0o755
    not_if { ::File.exist?(temp_bin) }
  end

  # Extract binary
  execute "extract #{new_resource.name} binary" do
    command "gunzip #{temp_bin}.gz"
    not_if { ::File.exist?(temp_bin) }
  end

  # Copy it to the root directory
  actual_path = "#{new_resource.prefix_root}/#{new_resource.name}-#{new_resource.version}"
  remote_file actual_path do
    source "file://#{temp_bin}"
    owner new_resource.user
    group new_resource.group
    mode 0o755
  end

  # Link it to the binary directory
  link "#{new_resource.prefix_bin}/#{new_resource.name}" do
    to actual_path
    owner new_resource.user
    group new_resource.group
    mode 0o755
    notifies :restart, "barito_loki_binary_systemd[#{new_resource.name}]"
  end
end
