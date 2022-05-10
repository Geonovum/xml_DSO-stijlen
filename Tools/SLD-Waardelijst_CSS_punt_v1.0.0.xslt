<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="xs math"  
    version="2.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xsl:param name="symbols" select="'../Symbols/png_laag/'"/>
    <!-- Van SLD naar CSS voor de waardelijst -->
    <!-- Van elke rule een stijl maken -->
    <xsl:template match="/">
        <xsl:apply-templates select="//*[local-name()='Rule']"/>
    </xsl:template>
    
    <xsl:template match="." >
        <xsl:variable name="symboolcode" select="./*[local-name()='Name']"/>
        <!-- WellKnownName -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'WellKnownName']/text()"/>
        <!-- fill -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'Fill']/*[local-name() = 'SvgParameter'][@name = 'fill']/text()"/>
        <!-- fill-opacity -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'Fill']/*[local-name() = 'SvgParameter'][@name = 'fill-opacity']/text()"/>
        <!-- stroke -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'Fill']/*[local-name() = 'SvgParameter'][@name = 'stroke']/text()"/>
        <!-- stroke-opacity -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'Fill']/*[local-name() = 'SvgParameter'][@name = 'stroke-opacity']/text()"/>
        <!-- stroke-width -->
        <xsl:variable name="stroke" select="./*[local-name() = 'PointSymbolizer']/*[local-name() = 'Graphic']/*[local-name() = 'Mark']/*[local-name() = 'Fill']/*[local-name() = 'SvgParameter'][@name = 'stroke-width']/text()"/>
        
        <!-- create point -->
        <xsl:text>&#xa;symboolcode punt[id='</xsl:text><xsl:value-of select="$symboolcode"/><xsl:text>']::after{</xsl:text>
        <xsl:text>&#xa;&#x9;content:'\00A0';</xsl:text>
        <xsl:text>&#xa;&#x9;width:24px;</xsl:text>
        <xsl:text>&#xa;&#x9;height:24px;</xsl:text>
        <xsl:text>&#xa;&#x9;background-repeat:no-repeat;</xsl:text>
        <xsl:text>&#xa;&#x9;background-image: url('</xsl:text><xsl:value-of select="concat($symbols,$symboolcode,'.png')"/>
        <xsl:text>')&#xa;&#x9;}</xsl:text>
    </xsl:template>
</xsl:stylesheet>