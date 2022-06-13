<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"  
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="xs xd math"  
    version="2.0">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 18, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> W10_admin</xd:p>
            <xd:p>Van SLD naar CSS voor de waardelijst</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <xsl:apply-templates select="//*[local-name()='Rule']"/>
    </xsl:template>
    <xd:doc>
        <xd:desc/>
    </xd:doc>
    <xsl:template match="." >
        <xsl:variable name="symboolcode" select="./*[local-name()='Name']"/>
        <xsl:variable name="stroke" select="./*[local-name() = 'LineSymbolizer']/*[local-name() = 'Stroke']/*[local-name() = 'SvgParameter'][@name = 'stroke']/text()"/>
        <xsl:variable name="stroke-dasharray" select="./*[local-name() = 'LineSymbolizer']/*[local-name() = 'Stroke']/*[local-name() = 'SvgParameter'][@name = 'stroke-dasharray']/text()"/>
        <xsl:variable name="stroke-linecap" select="./*[local-name() = 'LineSymbolizer']/*[local-name() = 'Stroke']/*[local-name() = 'SvgParameter'][@name = 'stroke-linecap']/text()"/>
        <xsl:variable name="stroke-opacity" select="./*[local-name() = 'LineSymbolizer']/*[local-name() = 'Stroke']/*[local-name() = 'SvgParameter'][@name = 'stroke-opacity']/text()"/>
        <xsl:variable name="stroke-width" select="./*[local-name() = 'LineSymbolizer']/*[local-name() = 'Stroke']/*[local-name() = 'SvgParameter'][@name = 'stroke-width']/text()"/>
        <!-- symboolcode -->
        <xsl:text>&#xa;symboolcode lijn[id='</xsl:text><xsl:value-of select="$symboolcode"/><xsl:text>']::after{</xsl:text>
        <!-- leeg element toevoegen -->
        <xsl:text>&#xa;&#x9;content:'\00A0';</xsl:text>
        <xsl:text>&#xa;&#x9;background-repeat: no-repeat;</xsl:text>
        <xsl:text>&#xa;&#x9;margin-right: 10px;</xsl:text>
        <!-- Lijn als svg in background-image -->
        <xsl:text>&#xa;&#x9;background-image: url("data:image/svg+xml,&lt;svg xmlns='http://www.w3.org/2000/svg' height='24px' width='48px'&gt;</xsl:text>
        <xsl:text>&lt;line x1='0' x2='58' y1='10' y2='10' style='</xsl:text>
        <xsl:text>stroke:</xsl:text><xsl:value-of select="replace($stroke,'#','%23')"/><xsl:text>;</xsl:text>
        <xsl:text>stroke-opacity: </xsl:text><xsl:value-of select="$stroke-opacity"/><xsl:text>;</xsl:text>
        <xsl:text>stroke-width:</xsl:text><xsl:value-of select="$stroke-width"/><xsl:text>;</xsl:text>
        <xsl:text>stroke-dasharray:</xsl:text>
        <xsl:choose>
            <xsl:when test="$stroke-dasharray"><xsl:value-of select="$stroke-dasharray"/></xsl:when>
            <xsl:otherwise>solid</xsl:otherwise>
        </xsl:choose><xsl:text>;</xsl:text>
        <xsl:text>stroke-linecap: </xsl:text><xsl:value-of select="$stroke-linecap"/><xsl:text>;</xsl:text>
        <xsl:text>'/&gt;</xsl:text>
        <xsl:text>&lt;/svg&gt;");</xsl:text>
        <xsl:text>&#xa;&#x9;}</xsl:text>
    </xsl:template>
</xsl:stylesheet>