require 'minitest/spec'

describe_recipe 'redis::source' do

  # It's often convenient to load these includes in a separate
  # helper along with
  # your own helper methods, but here we just include them directly:
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "packages" do
    it "installs the required package from source" do
      #file("#{node['redis']['source']['prefix']}/bin/redis-server").must_have(:mode, "644").with(:owner, "root").and(:group, "root")
      file("#{node['redis']['source']['prefix']}/bin/redis-server").must_have(:owner, "root").and(:group, "root")
    end
  end

  describe "configuration" do
    it "has a port specific configuration file" do
      #file("/etc/redis/#{node['redis']['port']}.conf").must_have(:mode, "644").with(:owner, "root").and(:group, "root")
      file("/etc/redis/#{node['redis']['port']}.conf").must_have(:owner, "root").and(:group, "root")
    end
  end

  describe "service" do
    it "has a executable init.d script" do
      #file("/etc/init.d/redis").must_have(:mode, "755").with(:owner, "root").and(:group, "root")
      file("/etc/init.d/redis").must_have(:owner, "root").and(:group, "root")
    end

    it "is running" do
      service("redis").must_be_running
    end
  end

  describe "run_state" do
    it "succeed" do
      run_status.success?.must_equal true
    end
  end
end
