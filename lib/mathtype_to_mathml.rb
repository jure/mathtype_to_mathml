require "mathtype_to_mathml/version"
require "nokogiri"
require "mathtype"
require_relative "mathtype_to_mathml/mover"
require_relative "mathtype_to_mathml/char_replacer"

module MathTypeToMathML
  class Converter
    def initialize(mathtype)
      @xslt = Nokogiri::XSLT(File.open(path_to_xslt))

      @mathtype = Mathtype::Converter.new(mathtype).xml.doc

      # Addresses lack of scaning mode in our translator. See "Mover" for more.
      mover = Mover.new(@mathtype)
      mover.move

      # Character ranges are tricky in XSLT 1.0, so we deal with them in Ruby
      char_replacer = CharReplacer.new(@mathtype)
      char_replacer.replace
    end

    def convert
      @mathtype.xpath(".//tmpl[selector='tmINTEG']").each do |ele|
        ele.xpath('.//slot/text()').each do |text|
          element = Nokogiri::XML::Element.new("mi", @mathtype)
          t = Nokogiri::XML::Text.new(text.text, @mathtype)
          element.prepend_child(t)
          text.replace(element)
        end
      end

      @mathtype.xpath('.//text()').each do |text|
        if text.parent.name == "slot" or text.parent.name == "pile"
          element = Nokogiri::XML::Element.new("mi", @mathtype)
          t = Nokogiri::XML::Text.new(text.text, @mathtype)
          element.prepend_child(t)
          text.replace(element)
        end
      end
      out = @xslt.transform(@mathtype)
      # This is a hack, but XML namespaces are such a pain to get
      # right, especially in nokigiri, so... We assume all content is
      # mathml, remove namespaces & set the root default namespace to
      # mathml
      out.remove_namespaces!
      out.root.default_namespace = 'http://www.w3.org/1998/Math/MathML'
      out.to_s
    end

    def path_to_xslt
      File.join(File.dirname(File.expand_path(__FILE__)), "transform.xsl")
    end
  end
end
