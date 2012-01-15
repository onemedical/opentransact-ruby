require File.dirname(__FILE__) + '/../spec_helper'

describe OpenTransact::TransferRequest do
  subject { transfer_request }
  let(:transfer_request) { OpenTransact::TransferRequest.new attributes }
  let(:asset) { OpenTransact::Asset.new asset_attributes }
  let(:attributes) { required_attributes }

  let :required_attributes do
    {
      :asset => asset
    }
  end

  let :asset_attributes do
    {
      :url => 'https://someurl.example.com/usd'
    }
  end

  its(:url) { should == 'https://someurl.example.com/usd' }
  its(:attributes) { should == {} }

  context "all parameters" do
    let(:attributes) do
      required_attributes.merge({
        :to => "alice@example.com",
        :from => "bob@example.com",
        :amount => 12.4,
        :note => "Thanks for that",
        :for => "http://stuff.sample.com/invoice/123",
        :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
        :callback_uri => "http://stuff.sample.com/invoice/123/cb"
      })
    end

    its(:url) { should == 'https://someurl.example.com/usd?amount=12.4&callback_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fcb&for=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123&from=bob%40example.com&note=Thanks+for+that&redirect_uri=http%3A%2F%2Fstuff.sample.com%2Finvoice%2F123%2Fredirect&to=alice%40example.com' }
    its(:attributes) { should == {
      :to => "alice@example.com",
      :from => "bob@example.com",
      :amount => 12.4,
      :note => "Thanks for that",
      :for => "http://stuff.sample.com/invoice/123",
      :redirect_uri => "http://stuff.sample.com/invoice/123/redirect",
      :callback_uri => "http://stuff.sample.com/invoice/123/cb"
      }
    }

  end



end