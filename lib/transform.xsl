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

    <!-- Non-empty text nodes -->
    <xsl:template match="text()[normalize-space()]">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="tmpl[selector = 'tmROOT']">
        <msqrt>
            <xsl:apply-templates/>
        </msqrt>
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


    <xsl:include href="xsl/int.xsl" />
    <xsl:include href="xsl/lim.xsl" />
    <xsl:include href="xsl/frac.xsl" />
    <xsl:include href="xsl/pile.xsl" />
    <xsl:include href="xsl/char.xsl" />
    <xsl:include href="xsl/embellishment.xsl" />
    <xsl:include href="xsl/subsup.xsl"/>
    <xsl:include href="xsl/sum.xsl"/>
    <xsl:include href="xsl/product_coproduct.xsl"/>
    <xsl:include href="xsl/union_intersection.xsl"/>
    <xsl:include href="xsl/box.xsl" />
    <xsl:include href="xsl/fence.xsl" />
    <xsl:include href="xsl/arrow.xsl"/>
    <xsl:include href="xsl/matrix.xsl"/>


</xsl:stylesheet>
