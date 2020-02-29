<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

     <!-- SQRT -->

     <xsl:template match="tmpl[selector='tmROOT' and variation='tvROOT_SQ']">
        <msqrt>
            <xsl:apply-templates select="slot[1] | pile[1]"/>
            <xsl:apply-templates select="slot[2] | pile[2]"/>
        </msqrt>
    </xsl:template>

    <xsl:template match="tmpl[selector='tmROOT' and variation='tvROOT_NTH']">
        <mroot>
            <xsl:apply-templates select="slot[1] | pile[1]"/>
            <xsl:apply-templates select="slot[2] | pile[2]"/>
        </mroot>
    </xsl:template>
</xsl:stylesheet>
