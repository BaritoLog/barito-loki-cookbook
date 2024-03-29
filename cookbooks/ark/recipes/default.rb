#
# Cookbook:: ark
# Recipe:: default
#
# Author:: Bryan W. Berry <bryan.berry@gmail.com>
# Copyright:: 2012-2017, Bryan W. Berry
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package node['ark']['package_dependencies'] unless %w[windows mac_os_x].include?(node['platform_family'])

include_recipe 'seven_zip' if node['platform_family'] == 'windows'
