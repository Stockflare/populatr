require 'spec_helper'

module Populatr
  describe Request do

    let(:response_url) { "http://some.location.on.aws.com" }

    let(:test_request) {
      {
        "RequestType" => "CREATE",
        "ResponseURL" => response_url,
        "ResourceType" => "Custom::Populatr",
        "StackId" => 1,
        "RequestId" => 2,
        "LogicalResourceId" => 3,
        "ResourceProperties" => {
          "Keys" => [
            {
              "Key" => "Test_A",
              "Value" => "A",
              "TTL" => "1000"
            },
            {
              "Key" => "Test_B",
              "Value" => "B"
            }
          ]
        }
      }
    }

    before { @request = Request.new(test_request) }

    subject { @request }

    it { should respond_to(:type) }

    it { should respond_to(:response_url) }

    it { should respond_to(:properties) }

    it { should respond_to(:keys) }

    it { should respond_to(:verbatim_response) }

    describe "return value of #type" do

      subject { @request.type }

      it { should be_a Symbol }

      it { should_not be_empty }

      it { should eq :create }

    end

    describe "return value of #response_url" do

      subject { @request.response_url }

      it { should be_a String }

      it { should_not be_empty }

      it { should eq response_url }

    end

    describe "return value of #properties" do

      subject { @request.properties }

      it { should be_a Hash }

      it { should_not be_empty }

    end

    describe "return value of #keys" do

      subject { @request.keys }

      it { should be_a Array }

      it { should_not be_empty }

      specify { expect(subject.sample).to be_an_instance_of Key }

    end

    describe "return value of #verbatim_response" do

      subject { @request.verbatim_response }

      it { should be_a Hash }

      it { should_not be_empty }

      specify { expect(subject.keys).to include "StackId", "RequestId", "LogicalResourceId" }

      specify { expect(subject.values).to include 1, 2, 3 }

    end

  end
end
