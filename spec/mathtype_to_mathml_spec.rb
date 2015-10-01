require 'spec_helper'

RSpec.describe MathTypeToMathML do
  it 'has a version number' do
    expect(MathTypeToMathML::VERSION).not_to be nil
  end

  Dir.glob('spec/fixtures/input/*.bin') do |equation|
    it "converted #{equation} matches expected output" do
      xml = MathTypeToMathML::Converter.new(equation).convert
      expected = File.open("spec/fixtures/expected/#{File.basename(equation, '.bin')}.xml").read
      expect(xml).to eq(expected)
    end
  end
end
