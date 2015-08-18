$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "mathtype_to_mathml"
require "nokogiri"

builder = Nokogiri::HTML::Builder.new do |html|
  html.html do
    html.body do
      Dir.glob("spec/fixtures/input/*.bin") do |equation|
        html.div do |div|
          div.h3 equation
          div.p "Output", "style" => "text-align: center;"
          div.p do |p|
            p << MathTypeToMathML::Converter.new(equation).convert
          end
          expected_xml = "#{File.basename(equation, ".*")}.xml"
          expected = File.open("spec/fixtures/expected/" + expected_xml).read
          div.p "Expected", "style" => "text-align: center;"
          div.p do |p|
            p << expected
          end
          div.hr
        end
      end
    end
  end
end

puts builder.to_html
