<?xml version="1.0" encoding="UTF-8"?>
<!--
// =====================================================
// Matrices
// =====================================================

// matrix translation (left, center, right)
matrix/l    = "<(ns)mtable columnalign='left'>$+$n#$-$n</(ns)mtable>";
matrix      = "<(ns)mtable>$+$n#$-$n</(ns)mtable>";
matrix/r    = "<(ns)mtable columnalign='right'>$+$n#$-$n</(ns)mtable>";

// matrix line translation (left, center, right)
matrow/l   = "<(ns)mtr columnalign='left'>$+$n#$-$n</(ns)mtr>$n";
matrow     = "<(ns)mtr>$+$n#$-$n</(ns)mtr>$n";
matrow/r   = "<(ns)mtr columnalign='right'>$+$n#$-$n</(ns)mtr>$n";

// matrix element translation (except for last element) (left, center, right)
matelem/l   = "<(ns)mtd columnalign='left'>$+$n#$-$n</(ns)mtd>$n";
matelem     = "<(ns)mtd>$+$n#$-$n</(ns)mtd>$n";
matelem/r   = "<(ns)mtd columnalign='right'>$+$n#$-$n</(ns)mtd>$n";

// matrix element translation (last element only) (left, center, right)
matelem/last/l   = "<(ns)mtd columnalign='left'>$+$n#$-$n</(ns)mtd>";
matelem/last     = "<(ns)mtd>$+$n#$-$n</(ns)mtd>";
matelem/last/r   = "<(ns)mtd columnalign='right'>$+$n#$-$n</(ns)mtd>";
 -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

    <!-- Matrices TODO -->
    <xsl:template match="matrix">
        <mtable columnalign="left">
            <xsl:variable name="rows" select="number(rows)"/>

            <xsl:apply-templates select="slot[position() mod $rows = 1]" mode="rows" />
        </mtable>
    </xsl:template>

<!--

    <xsl:template match="matrix">
        <mtable>
            <xsl:apply-templates select="slot[1]"/>
        </mtable>
    </xsl:template>

    <xsl:template match="matrix">
        <mtable columnalign="right">
            <xsl:apply-templates select="slot[1]"/>
        </mtable>
    </xsl:template>

-->

    <xsl:template name="matrow" match="slot" mode="rows">
        <xsl:variable name="rows" select="number(parent::*/rows)"/>
        <mtr columnalign="left">
            <xsl:apply-templates select="." mode="columns" />
            <xsl:apply-templates select="following-sibling::slot[position() &lt; $rows]" mode="columns" />
        </mtr>
    </xsl:template>

<!--
    <xsl:template match="matrow">
        <mtr>
            <xsl:apply-templates select="slot[1]"/>
        </mtr>
    </xsl:template>

    <xsl:template match="matrow">
        <mtr columnalign="right">
            <xsl:apply-templates select="slot[1]"/>
        </mtr>
    </xsl:template>
 -->

    <xsl:template name="matelem" match="slot" mode="columns">
        <mtd columnalign="left">
            <xsl:apply-templates />
        </mtd>
    </xsl:template>

<!--     <xsl:template match="matelem">
        <mtd>
            <xsl:apply-templates select="slot[1]"/>
        </mtd>
    </xsl:template>

    <xsl:template match="matelem">
        <mtd columnalign="right">
            <xsl:apply-templates select="slot[1]"/>
        </mtd>
    </xsl:template>

    <xsl:template match="matelem">
        <mtd columnalign="left">
            <xsl:apply-templates select="slot[1]"/>
        </mtd>
    </xsl:template>

    <xsl:template match="matelem">
        <mtd>
            <xsl:apply-templates select="slot[1]"/>
        </mtd>
    </xsl:template>

    <xsl:template match="matelem">
        <mtd columnalign="right">
            <xsl:apply-templates select="slot[1]"/>
        </mtd>
    </xsl:template> -->
</xsl:stylesheet>
