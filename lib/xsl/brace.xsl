<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

    <!-- Braces -->

    <xsl:template match="tmpl[selector='tmBRACK' ]">
        <mrow><mo>[</mo>
            <xsl:apply-templates select="slot[1]"/> <mo>]</mo>
        </mrow>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmBRACE' ]">
        <mrow><mo>{</mo>
            <xsl:apply-templates select="slot[1]"/> <mo>}</mo>
        </mrow>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmANGLE' ]">
        <mrow><mo>&#x2329;</mo>
            <xsl:apply-templates select="slot[1]"/> <mo>&#x232A;</mo>
        </mrow>
    </xsl:template>

    <!-- Dirac -->

    <xsl:template match="tmpl[selector='tmDIRAC' and variation='tvDI_RIGHT']">
      <mrow>
        <mo>|</mo>
        <xsl:apply-templates select="slot[2]"/>
        <mo>&#x232A;</mo>
      </mrow>
    </xsl:template>


    <xsl:template match="tmpl[selector='tmDIRAC' and variation='tvDI_LEFT']">
      <mrow>
        <mo>&#x2329;</mo>
        <xsl:apply-templates select="slot[1]"/>
        <mo>|</mo>
      </mrow>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmDIRAC' and variation='tvDI_LEFT' and variation='tvDI_RIGHT']">
      <mrow>
        <mo>&#x2329;</mo>
        <xsl:apply-templates select="slot[1]"/>
        <mo>|</mo>
        <xsl:apply-templates select="slot[2]"/>
        <mo>&#x232A;</mo>
      </mrow>
    </xsl:template>
</xsl:stylesheet>
