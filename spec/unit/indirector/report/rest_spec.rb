#! /usr/bin/env ruby -S rspec
require 'spec_helper'

require 'puppet/indirector/report/rest'

describe Puppet::Transaction::Report::Rest do
  it "should be a subclass of Puppet::Indirector::REST" do
    Puppet::Transaction::Report::Rest.superclass.should equal(Puppet::Indirector::REST)
  end

  it "should use the :report_server setting in preference to :server" do
    Puppet.settings[:server] = "server"
    Puppet.settings[:report_server] = "report_server"
    Puppet::Transaction::Report::Rest.server.should == "report_server"
  end

  it "should have a value for report_server and report_port" do
    Puppet::Transaction::Report::Rest.server.should_not be_nil
    Puppet::Transaction::Report::Rest.port.should_not be_nil
  end

  it "should use the :report SRV service" do
    Puppet::Transaction::Report::Rest.srv_service.should == :report
  end
end
