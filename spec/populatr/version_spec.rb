describe Populatr do

  it "should have a valid version number" do
    expect(Gem::Version.correct?(Populatr::VERSION)).to eq(0)
  end

end
