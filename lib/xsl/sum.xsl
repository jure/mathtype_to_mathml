<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

     <!-- Summations -->

    <xsl:template match="tmpl[selector='tmSUM' and (not(variation='tvBO_UPPER') and not(variation='tvBO_UPPER'))]">
        <mstyle displaystyle="true">
            <mo>&#x2211;</mo>
            <xsl:apply-templates select="slot[1]"/>
        </mstyle>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmSUM' and variation='tvBO_LOWER']">
        <mstyle displaystyle="true">
            <munder>
                <mo>&#x2211;</mo>
                <xsl:apply-templates select="slot[2]"/>
            </munder>
            <xsl:apply-templates select="slot[1]"/>
        </mstyle>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmSUM']">
        <mstyle displaystyle="true">
            <munderover>
                <mo>&#x2211;</mo>
                <xsl:apply-templates select="slot[2]"/>
                <xsl:apply-templates select="slot[3]"/>
            </munderover>
            <xsl:apply-templates select="slot[1]"/>
        </mstyle>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmSUM' and not(variation='tvBO_SUM') and variation='tvBO_LOWER']">
        <mstyle displaystyle="true">
            <msub>
                <mo>&#x2211;</mo>
                <xsl:apply-templates select="slot[2]"/>
            </msub>
        <xsl:apply-templates select="slot[1]"/>
        </mstyle>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmSUM' and not(variation='tvBO_SUM')]">
        <mstyle displaystyle="true">
            <msubsup>
                <mo>&#x2211;</mo>
                <xsl:apply-templates select="slot[2]"/>
                <xsl:apply-templates select="slot[3]"/>
            </msubsup>
        <xsl:apply-templates select="slot[1]"/>
        </mstyle>
    </xsl:template>
</xsl:stylesheet>
