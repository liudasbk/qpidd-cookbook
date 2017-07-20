module QpiddCookbook
  module Helper

    def qpid_name
      "qpidd-#{new_resource.instance_name}"
    end

    def config_vars
      vars = []
      no_args = [
        'no-data-dir',
        'tcp-nodelay',
        'require-encryption',
        'ssl-use-export-policy',
        'ssl-require-client-authentication',
        'ssl-sasl-no-dict']

      new_resource.variables.each do |name, val|
        if no_args.include? name
          vars << name
        elsif [true, false].include? val
          vars << "#{name}=#{ val ? 'yes' : 'no' }"
        else
          vars << "#{name}=#{val}"
        end
      end
      vars
    end

    def data_dir
      if node['platform_family'] == 'debian'
        "/var/spool/#{qpid_name}"
      else
        "/var/lib/#{qpid_name}"
      end
    end

    def create_dirs
      directory "/etc/#{qpid_name}" do
        owner 'root'
        group 'root'
        mode 0o0755
      end

      directory data_dir do
        owner 'qpidd'
        group 'qpidd'
        mode 0o0750
      end

      directory "/var/run/#{qpid_name}" do
        owner 'qpidd'
        group 'qpidd'
        mode 0o0750
      end
    end

    def create_config
      template "/etc/#{qpid_name}/qpidd.conf" do
        source 'qpidd.conf.erb'
        owner 'root'
        group 'root'
        mode 0o0644
        cookbook 'qpidd'
        variables(
          data_dir: data_dir,
          port: new_resource.port,
          interface: new_resource.interface,
          variables: config_vars
        )
        action :create
      end
    end

    def broker_packages
      case node['platform_family']
      when 'rhel', 'fedora'
        %w[qpid-cpp-server qpid-tools]
      when 'debian'
        %w[qpidd qpid-tools]
      end
    end
  end
end
