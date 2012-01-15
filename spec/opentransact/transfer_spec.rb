require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::Transfer do
  subject { transfer }
  let(:transfer) { OpenTransact::Transfer.new attributes }
  let(:asset) { OpenTransact::Asset.new asset_attributes }
  let(:attributes) { required_attributes }
  let(:access_token) { double("access_token") }

  let :required_attributes do
    {
      :asset => asset,
      :access_token => access_token
    }
  end

  let :asset_attributes do
    {
      :url => 'https://someurl.example.com/usd'
    }
  end

  its(:url) { should == 'https://someurl.example.com/usd' }
  its(:access_token) { should == access_token }
  its(:attributes) { should == { } }

  context "all parameters" do
    let(:attributes) do
      required_attributes.merge({
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123"
      })
    end

    its(:url) { should == 'https://someurl.example.com/usd' }
    its(:attributes) { should == {
      :to => "alice@example.com",
      :from => "bob@example.com",
      :amount => 12.4,
      :note => "Thanks for that",
      :for => "http://stuff.sample.com/invoice/123"
      }
    }

    it "should create post request" do
      access_token.should_receive(:post).with('https://someurl.example.com/usd',  'amount=12.4&for=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123&from=bob%40example.com&note=Thanks+for+that&to=alice%40example.com')
      transfer.perform!
    end

  end



end