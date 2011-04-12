require File.dirname(__FILE__) + '/../spec_helper'

describe VaporFlow do
  describe "radiant_path" do
    it "should return the given path prepended with a /" do
      VaporFlow.radiant_path('slashy').should == '/slashy'
    end
  end
  describe "local_or_external_path" do
    it "should return the given path if it begins with 'http'" do
      VaporFlow.local_or_external_path('http://saturnflyer.com').should == 'http://saturnflyer.com'
    end
    it "should return the given path if it begins with 'https'" do
      VaporFlow.local_or_external_path('https://saturnflyer.com').should == 'https://saturnflyer.com'
    end
    it "should return the radiant_path if the given path does not begin with http" do
      VaporFlow.local_or_external_path('about/the/site').should == VaporFlow.radiant_path('about/the/site')
    end
  end
  describe "send_to_radiant" do
    it "should return an array" do
      VaporFlow.send_to_radiant.kind_of?(Array).should be_true
    end
    it "should have 404 as the first item in the array" do
      VaporFlow.send_to_radiant.first.should == 404
    end
  end
end