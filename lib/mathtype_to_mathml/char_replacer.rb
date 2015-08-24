require "nokogiri"

# XSLT 1.0 has virtually non-existent capabilities for character ranges,
# codepoints, hex to decimal, etc., so we replace characters within character
# ranges with Ruby. Additonally, it's not possible to get the actual character
# represented by a hexadecimal number in XSLT, so we deal with those here too.
# Regular single character translations are still done with XSLT (char.xsl).




module MathTypeToMathML
  class CharReplacer
    UNSUPPORTED = "Unsupported (Char)"

    DEFAULT_TEXTMODE = "(Char)"
    DEFAULT_MATHMODE = "<mi>(Char)<mi>"

    REPLACEMENTS = {
      0x0021 => { # Exclamation mark
        mathmode: "<mo>(Char)</mo>"
      },
      0x0028 => { # Left parenthesis
        mathmode: "<mo stretchy='false'>(Char)</mo>"
      },
      0x0029 => { # Right parenthesis
        mathmode: "<mo stretchy='false'>(Char)</mo>"
      },
      0x002A => { # Asterisk
        mathmode: "<mo>(Char)</mo>"
      },
      0x002B => { # Plus sign
        mathmode: "<mo>(Char)</mo>"
      },
      0x002C => { # Plus sign
        mathmode: "<mo>(Char)</mo>"
      },
      0x002D => { # Hyphen-minus
        mathmode: "<mo>(Char)</mo>"
      },
      0x002E => { # Full stop
        mathmode: "<mo>(Char)</mo>"
      },
      0x002F => { # Solidus
        mathmode: "<mo>(Char)</mo>"
      },
      0x003D => { # Equals sign
        mathmode: "<mo>(Char)</mo>"
      },
      0x003F => { # Question mark
        mathmode: "<mo>(Char)</mo>"
      },
      0x005B => { # Left square bracket
        mathmode: "<mo stretchy='false'>(Char)</mo>"
      },
      0x005D => { # Right square bracket
        mathmode: "<mo stretchy='false'>(Char)</mo>"
      },
      0x007E => { # Tilda
        mathmode: "<mo>(Char)</mo>"
      },
      0x0000..0x0008 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x000B..0x001F => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x0030..0x0039 => { # (range) DIGITS 0-9
        mathmode: "<mn>(Char)</mn>",
        number: "(Char)",
        textmode: "(Char)"
      },
      0x003A..0x003B => { # (range) COLON, SEMICOLON
        mathmode: "<mo>(Char)</mo>",
        textmode: "(Char)"
      },
      0x0041..0x005A => { # range: Basic Latin
        mathmode: "<mi>(Char)</mi>",
        textmode: "(Char)"
      },
      0x0061..0x007A => { # range: Basic Latin
        mathmode: "<mi>(Char)</mi>",
        textmode: "(Char)"
      },
      0x0080..0x009F => { # range: C1 Controls
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x00A0..0x00B0 => { # range: Latin-1 Supplement
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x00B2..0x00BB => { # range: Latin-1 Supplement
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x00BC..0x00BE => { # range: Latin-1 Supplement
        mathmode: "<mn>(CharHex)</mn>"
      },
      0x02C6..0x02FF => { # range: Spacing Modifier Letters
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x0300..0x036F => { # range: Combining Diacritical Marks
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2000..0x200B => { # range: Spaces
        mathmode: "<mtext>(CharHex)</mtext>"
      },
      0x200C..0x200F => { # range: Formatting Characters
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x2010..0x2027 => { # range: General Punctuation
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2028..0x202F => { # range: Formatting Characters
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x2030..0x2069 => { # range: General Punctuation
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x206A..0x206F => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0x2070..0x209F => { # range: Superscripts and Subscripts
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x20A0..0x20CF => { # range: Currency Symbols
        mathmode: "<mi>(CharHex)</mi>"
      },
      0x20D0..0x20FF => { # range: Combining Diacritical Marks for Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2100..0x2101 => { # range: Letterlike Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2103..0x210A => { # range: CJK Symbols and Punctuation
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2116..0x2117 => { # range: Supplemental Mathematical Operators
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x213C..0x2146 => { # range: Miscellaneous Mathematical Symbols-B
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2150..0x218F => { # range: Miscellaneous Mathematical Symbols-B
        mathmode: "<mn>(CharHex)</mn>"
      },
      0x2190..0x21FF => { # range: Miscellaneous Mathematical Symbols-B
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2200..0x2211 => { # range: Supplemental Arrows-B
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2213..0x221D => { # range: Supplemental Arrows-A
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x221F..0x22FF => { # range: Dingbats
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2300..0x23FF => { # range: Miscellaneous Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2400..0x243F => { # range: Geometric Shapes
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2500..0x257F => { # range: Block Elements
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2580..0x259F => { # range: Box Drawing
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x25A0..0x25FF => { # range: Control Pictures
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2600..0x267F => { # range: Miscellaneous Technical
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2700..0x27BF => { # range: Mathematical Operators
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x27F0..0x27FF => { # range: Mathematical Operators
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2900..0x297F => { # range: Mathematical Operators
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2980..0x29AF => { # range: Arrows
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x29B1..0x29DB => { # range: Number Forms
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x29DD..0x29FF => { # range: Letterlike Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x2A00..0x2AFF => { # range: Letterlike Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0x3000..0x303F => { # range: Letterlike Symbols
        mathmode: "<mo>(CharHex)</mo>"
      },
      0xE000..0xE900 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE905..0xE90A => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE90D..0xE921 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE926..0xE92C => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE92E..0xE931 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE934..0xE939 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE93C..0xE98E => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xE990..0xEA05 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEA08..0xEA0A => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEA0D..0xEA31 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEA36..0xEA39 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEA3C..0xEA3F => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEA46..0xEB00 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEB03..0xEB04 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEB07..0xED09 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xED14..0xED15 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xED17..0xEE03 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEE04..0xEE0C => {
        textmode: UNSUPPORTED
      },
      0xEE0D..0xEE18 => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEE1A..0xEEFF => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xEF09..0xEFFF => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xF000..0xF033 => {
        textmode: UNSUPPORTED
      },
      0xF034..0xF07F => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xF080..0xF0B3 => {
        textmode: UNSUPPORTED
      },
      0xF0B4..0xF0BF => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xF0C0..0xF0C9 => {
        textmode: UNSUPPORTED
      },
      0xF0CA..0xF0FF => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xF100..0xF133 => {
        textmode: UNSUPPORTED
      },
      0xF134..0xF8FF => {
        mathmode: UNSUPPORTED,
        textmode: UNSUPPORTED
      },
      0xFB00..0xFB4F => { # range: Alphabetic Presentation Forms
        mathmode: "<mtext>(CharHex)</mtext>"
      },
      0xFE35..0xFE4F => { # range: CJK Compatibility Forms
        mathmode: "<mo>(CharHex)</mo>"
      }
    }

    attr_accessor :mathtype

    def initialize(mathtype)
      @mathtype = mathtype
    end

    def replace
      @mathtype.css("char").each do |char|
        replacement = REPLACEMENTS.find do |range, _|
          range === char.xpath("mt_code_value").text.hex
        end
        replace_character(replacement, char) if replacement
      end

      # Reparse XML to merge adjacent text nodes
      @mathtype = Nokogiri::XML(@mathtype.to_xml)
    end

    def replace_character(replacement, char)
      if char.xpath("variation = 'textmode'")
        replacement = replacement[1][:textmode] || DEFAULT_TEXTMODE
        xml = replacement_xml(replacement, char)
      else
        replacement = replacement[1][:mathmode] || DEFAULT_MATHMODE
        xml = replacement_xml(replacement, char)
      end

      char.replace Nokogiri::HTML::DocumentFragment.parse(xml)
    end

    def replacement_xml(string, char)
      string.gsub("(Char)") do
        char.xpath("mt_code_value").text.hex.chr("UTF-8") # e.g. π
      end.gsub("(CharHex)") do
        "&#x#{char.xpath('mt_code_value').text[2..-1]};" # e.g. &#x2229;
      end
    end
  end
end




