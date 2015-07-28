Facter.add("ips") do
  setcode do
    #Get all the network interfaces except lo
    interfaces = Facter.value("networking")["interfaces"]
    interfaces.delete("lo")
    ips = interfaces.collect {|k, v| v["ip"]}
    ips
  end
end
