
if node['platform_family'] == 'rhel'
  yum_repository 'epel' do
    if node['platform_version'].to_i == 7
      mirrorlist  'http://mirrors.fedoraproject.org/mirrorlist' \
                  '?repo=epel-7&arch=$basearch'
      description 'Extra Packages for Enterprise Linux 7 - $basearch'
      gpgkey      'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
    else
      mirrorlist  'http://mirrors.fedoraproject.org/mirrorlist' \
                  '?repo=epel-6&arch=$basearch'
      description 'Extra Packages for Enterprise Linux 6 - $basearch'
      gpgkey      'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
    end
    gpgcheck    true
    action      :create
  end
end
