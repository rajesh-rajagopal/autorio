module Autorio::Params
  CONFIG_PARAMS = %i[version
                     selected_version
                     master
                     db
                     storlet
                     nodelet
                     fluentbit
                     MY_IP_ADDRESS
                     RIOOS_REPO
                     RIOOS_REPO_USER
                     RIOOS_REPO_PASSWORD
                     RIOOS_REGISTRY
                     RIOOS_HOME
                     RIOOS_CONFIG_HOME
                     DNS_ENDPOINT
                     API_SERVER
                     WATCH_SERVER
  ].freeze

  def self.ARGVS
    return {} if ARGV.length <= 2

    cut_args = ARGV.slice(1..-1).map { |s| s.split("=") }.flatten

    Hash[*cut_args].map { |k, v| [k.to_sym, v] }.to_h
  end
end
