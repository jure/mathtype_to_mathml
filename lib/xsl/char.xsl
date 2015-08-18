<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

    <xsl:template match="mi | mo | mn | mtext">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x2026']">
        <mo>&#x2026;</mo>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x22EE' ]">
      <mo>&#x22EE;</mo>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x22F1' ]">
      <mo>&#x22F1;</mo>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x22EF' ]">
      <mo>&#x22EF;</mo>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x03C0' ]">
        <mi>π</mi>
    </xsl:template>

    <xsl:template match="char[mt_code_value='0x03B8' ]">
        <mi>θ</mi>
    </xsl:template>

</xsl:stylesheet>
