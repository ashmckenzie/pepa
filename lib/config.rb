require 'yaml'

CONFIG_YAML = 'config.yaml'
CONFIG_LOCAL_YAML = 'config_local.yaml'

$config = YAML.load_file(CONFIG_YAML)

if Pathname.new(CONFIG_LOCAL_YAML).exist?
  config = $config.deeper_merge(YAML.load_file(CONFIG_LOCAL_YAML), { :merge_hash_arrays => true })
end