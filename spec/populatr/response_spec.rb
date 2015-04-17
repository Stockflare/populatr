module Populatr
  describe Response do

    let(:response_url) { "https://foo:bar@some.location.on.aws.com" }

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

    let(:request) { Request.new(test_request) }

    before { stub_request(:any, response_url) }

    before { @response = Response.new(request) }

    subject { @response }

    it { should respond_to(:with_success!) }

    it { should respond_to(:with_failed!) }

    describe 'when #with_success! is called' do

      let(:test_body) { { "Foo" => "Bar" } }

      let(:uri) { URI(response_url) }

      specify { expect(subject).to receive(:send) }

      specify { expect(subject).to receive(:send).with(kind_of(Hash)) }

      specify { expect(subject).to receive(:send).with(hash_including(Status: "SUCCESS")) }

      specify { expect(subject).to receive(:send).with(hash_including(Data: test_body)) }

      specify { expect(subject).to receive(:send).with(hash_including(request.verbatim_response)) }

      specify { expect(Net::HTTP).to receive(:start).with(uri.host, uri.port) }

      specify { expect_any_instance_of(Net::HTTP).to receive(:request).with(kind_of(Net::HTTP::Put)) }

      after { subject.with_success! test_body }

    end

    describe 'when #with_failed! is called' do

      let(:test_reason) { "it failed" }

      let(:uri) { URI(response_url) }

      specify { expect(subject).to receive(:send) }

      specify { expect(subject).to receive(:send).with(kind_of(Hash)) }

      specify { expect(subject).to receive(:send).with(hash_including(Status: "FAILED")) }

      specify { expect(subject).to receive(:send).with(hash_including(Reason: test_reason)) }

      specify { expect(subject).to receive(:send).with(hash_including(request.verbatim_response)) }

      specify { expect(Net::HTTP).to receive(:start).with(uri.host, uri.port) }

      specify { expect_any_instance_of(Net::HTTP).to receive(:request).with(kind_of(Net::HTTP::Put)) }

      after { subject.with_failed! test_reason }

    end

  end
end
