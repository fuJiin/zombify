require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Zombify" do

  it "should decrypt what it encrypts" do

    Zombify.configure do |z|
      z.salt = "H#K8SLP"
      z.key  = 32.times.map{ "x" }.join
    end

    str  = "Some Important Info"
    pass = Zombify.encrypt(str)
    out  = Zombify.decrypt(pass)

    str.should == out
  end
end
