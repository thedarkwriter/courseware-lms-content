module Puppet::Parser::Functions
  newfunction(:bogus_function) do |args|
    args[0] + args[1]
  end
end
