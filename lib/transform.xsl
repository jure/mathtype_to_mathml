<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <xsl:template match="/">
        <xsl:apply-templates select=".//mtef" />
    </xsl:template>

    <xsl:template match="mtef">
        <math display="block">
            <xsl:apply-templates select="pile | slot"/>
        </math>
    </xsl:template>

    <xsl:template match="tmpl[selector = 'tmFRACT']">
        <mfrac>
            <xsl:apply-templates select="slot[1]"/>
            <xsl:apply-templates select="slot[2]"/>
        </mfrac>
    </xsl:template>

    <xsl:template match="slot">
        <mrow>
            <xsl:apply-templates/>
        </mrow>
    </xsl:template>

    <xsl:template match="tmpl[selector = 'tmROOT']">
        <msqrt>
            <xsl:apply-templates/>
        </msqrt>
    </xsl:template>

    <xsl:template match="char[typeface = '2']">
        <mn>
            <xsl:text disable-output-escaping="yes">&amp;#</xsl:text>
            <xsl:value-of select="substring(mt_code_value/text(), 2)"/>
            <xsl:text>;</xsl:text>
        </mn>
    </xsl:template>

    <xsl:template match="char[typeface = '8']">
        <mn>
            <xsl:text disable-output-escaping="yes">&amp;#</xsl:text>
            <xsl:value-of select="substring(mt_code_value/text(), 2)"/>
            <xsl:text>;</xsl:text>
        </mn>
    </xsl:template>

    <xsl:template match="char[typeface = '3']">
        <mi>
            <xsl:text disable-output-escaping="yes">&amp;#</xsl:text>
            <xsl:value-of select="substring(mt_code_value/text(), 2)"/>
            <xsl:text>;</xsl:text>
        </mi>
    </xsl:template>

    <xsl:template match="char[typeface = '6']">
        <mo>
            <xsl:text disable-output-escaping="yes">&amp;#</xsl:text>
            <xsl:value-of select="substring(mt_code_value/text(), 2)"/>
            <xsl:text>;</xsl:text>
        </mo>
    </xsl:template>

    <xsl:template match="*" />

    <xsl:template match="tmpl[selector='tmROOT' and variation='tvROOT_NTH']">
        <mroot>
            <xsl:apply-templates select="slot[1]" />
            <xsl:apply-templates select="slot[2]" />
        </mroot>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmARROW']">
        <munderover accentunder="true">
            <mstyle scriptlevel="-1"><mo>&#x21C0;</mo></mstyle>
            <munder>
                <mstyle scriptlevel="+1"><mo>&#x21BD;</mo></mstyle>
                <xsl:apply-templates select="slot[1]" />
                <xsl:apply-templates select="slot[2]" />
            </munder>
        </munderover>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmPAREN']">
        <mrow><mo>(</mo>
        <xsl:apply-templates select="slot[1]"/>
        <mo>)</mo></mrow>
    </xsl:template>

    <xsl:include href="lib/xsl/pile.xsl" />
    <xsl:include href="lib/xsl/char.xsl" />
    <xsl:include href="lib/xsl/embellishment.xsl" />
    <xsl:include href="lib/xsl/subsup.xsl"/>
    <xsl:include href="lib/xsl/sum.xsl"/>
    <xsl:include href="lib/xsl/union_intersection.xsl"/>
    <xsl:include href="lib/xsl/arrow.xsl"/>
    <xsl:include href="lib/xsl/matrix.xsl"/>
    <xsl:include href="lib/xsl/brace.xsl"/>


</xsl:stylesheet>
