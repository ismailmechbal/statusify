module Statusify
  # Our module. Does awesome stuff like loading config.
  require_relative '../../lib/statusify/config'
  include Config
  extend Config
end