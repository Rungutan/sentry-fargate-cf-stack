# frozen_string_literal: true

bash 'disable-swap-and-set-sysctl' do
  user 'root'
  code <<-BASH
    swapoff -a
    sysctl -w vm.max_map_count=262144
    sysctl -w fs.file-max=65536
  BASH
end
