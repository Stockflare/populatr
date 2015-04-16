module Populatr
  describe Key do

    let(:test_array) {
      [
        {
          "Key" => "foo",
          "Value" => "bar"
        },
        {
          "Key" => "foo",
          "Value" => "bar",
          "TTL" => "1000"
        }
      ]
    }

    before { @key = Key.new.merge! test_array.sample }

    subject { @key }

    specify { expect(Key).to respond_to(:from_array) }

    it { should respond_to(:key) }

    it { should respond_to(:value) }

    it { should respond_to(:ttl) }

    it { should respond_to(:to_args) }

    it { should respond_to(:properties) }

    describe 'return value of #to_args' do

      subject { @key.to_args }

      it { should be_a Array }

      it { should_not be_empty }

      specify { expect(subject.length).to eq 2 }

      specify { expect(subject).to eq [@key.key, @key.properties] }

    end

    describe 'return value of #properties' do

      subject { @key.properties }

      it { should be_a Hash }

      it { should_not be_empty }

      specify { expect(subject.keys).to include :value }

    end

    describe 'return value of #key' do

      subject { @key.key }

      it { should be_a String }

      it { should_not be_empty }

      it { should eq "foo" }

    end

    describe 'return value of #value' do

      subject { @key.value }

      it { should be_a String }

      it { should_not be_empty }

      it { should eq "bar" }

    end

  end
end
