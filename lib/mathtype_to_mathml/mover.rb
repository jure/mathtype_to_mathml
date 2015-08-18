require "nokogiri"

# We're moving elements around to avoid "scanning" for characters when
# using the /scan translator mode. The original issue is that MathType
# considers subscripts and superscripts to be stand-alone, while MathML
# considers them subscripts and superscripts of an object, and the object
# is then included in the sub/superscript element.

# MathType's translator has a scan mode, which does the following:
# 1. Scanning goes to the right for commands with the "pre" option,
#   otherwise left;
# 2. If we are scanning right and the object next to the template is an
#   opening "fence" character (parenthesis, bracket, brace, etc.),
#   the slot is scanned for the corresponding closing fence character;
# 3. If we are scanning left and the object next to the template is an closing
#   "fence" character (parenthesis, bracket, brace, etc.), the slot is scanned
#   for the corresponding opening fence character;
# 4. If the fenced expression is found, it is used as #1 in the template translation.

# Additionally, Mover inverts <emb>ellishments from <char><emb></emb></char> to
# <emb><char></char></emb>.

module MathTypeToMathML
  class Mover
    attr_reader :mathtype
    attr_accessor :last_preceding_siblings

    PARENS_SELECTOR = "selector='tmPARENS' or "\
      "selector='tmBRACK' or " \
      "selector='tmBRACE' or " \
      "selector='tmOBRACK' or " \
      "selector='tmOBRACE' or " \
      "selector='tmHBRACK' or " \
      "selector='tmHBRACE'"

    SUBSUP_SELECTOR = "selector='tmSUP' or " \
      "selector='tmSUB' or " \
      "selector='tmSUBSUP'"

    PRE = "variation='tvSU_PRECEDES'"

    OPEN_PAREN = "mt_code_value = '0x0028' or " \
      "mt_code_value = '0x005B' or " \
      "mt_code_value = '0x007B'"

    CLOSE_PAREN = "mt_code_value = '0x0029' or " \
      "mt_code_value = '0x005D' or " \
      "mt_code_value = '0x007D'"

    OPEN_CLOSE_PAIRS = {
      "0x0028" => "0x0029", # ( )
      "0x005B" => "0x005D", # [ ]
      "0x007B" => "0x007D", # { }
    }

    def initialize(mathtype)
      @mathtype = mathtype
      @last_preceding_siblings = Nokogiri::XML::NodeSet.new(@mathtype)
    end

    def move_until_mt_code(elements, mt_code_value, parent)
      elements.each do |element|
        element.parent = parent
        break if element.xpath("mt_code_value = '#{mt_code_value}'")
      end
    end

    def move_paren(siblings, node)
      OPEN_CLOSE_PAIRS.each do |open, close|
        if siblings[0].xpath("mt_code_value = '#{open}'") # ( )
          move_until_mt_code(siblings, close, node)
        end
      end
    end

    def new_preceding_siblings(el)
      all_siblings = el.xpath("preceding-sibling::tmpl | preceding-sibling::char")
      siblings = all_siblings - last_preceding_siblings
      self.last_preceding_siblings = all_siblings
      siblings
    end

    def new_following_siblings(el)
      el.xpath("following-sibling::tmpl | following-sibling::char")
    end

    def move_following_subsup
      mathtype.xpath("//tmpl[(#{SUBSUP_SELECTOR}) and not(#{PRE})]").each do |el|
        siblings = new_preceding_siblings(el)

        node = Nokogiri::XML::Node.new "slot", mathtype

        if siblings.last.xpath(CLOSE_PAREN)
          siblings = siblings.reverse.take_while do |sibling|
            !sibling.next_element.xpath(OPEN_PAREN)
          end.reverse

          move_paren(siblings, node)
        elsif siblings.last.xpath("self::tmpl[#{PARENS_SELECTOR}]")
          siblings.last.parent = node
        else
          siblings.last.parent = node
        end

        el.at_css("slot").add_previous_sibling node
      end
    end

    def move_preceding_subsup
      mathtype.xpath("//tmpl[(#{SUBSUP_SELECTOR}) and #{PRE}]").each do |el|
        siblings = new_following_siblings(el)

        node = Nokogiri::XML::Node.new "slot", mathtype

        if siblings.first.xpath(OPEN_PAREN)
          siblings = siblings.reverse.take_while do |sibling|
            !sibling.next_element.xpath(CLOSE_PAREN)
          end.reverse

          move_paren(siblings, node)
        elsif siblings.first.xpath("self::tmpl[#{PARENS_SELECTOR}]")
          siblings.first.parent = node
        else
          siblings.first.parent = node
        end

        el.at_css("slot").add_previous_sibling node
      end
    end

    def invert_char_embell
      # Invert char -> embell to embell -> char.
      mathtype.xpath("//char[embell]").each do |el|
        embell = el.xpath("embell").first.remove
        char = el.clone
        char.parent = embell
        el.replace(embell)
      end
    end

    def move
      move_following_subsup
      move_preceding_subsup
      invert_char_embell
    end
  end
end




