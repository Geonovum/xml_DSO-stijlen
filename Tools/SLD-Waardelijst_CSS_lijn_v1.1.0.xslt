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
        <!--  -->
        <xsl:text>&#xa;symboolcode lijn[id='</xsl:text><xsl:value-of select="$symboolcode"/><xsl:text>']::after{</xsl:text> 
        <xsl:text>&#xa;&#x9;content:'\00A0';</xsl:text>
        <xsl:text>&#xa;&#x9;background-repeat: no-repeat;</xsl:text>
        <xsl:text>&#xa;&#x9;background-image: url("data:image/svg+xml;utf8,&lt;svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' version='1.1' width='48px' height='24px' xml:space='preserve'&gt;&lt;g&gt;&lt;line style='stroke: rgb(</xsl:text>
        <xsl:call-template name="hex2num">
            <xsl:with-param name="hex">
                <xsl:value-of select="fn:substring($stroke, 2, 2)"/>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="hex2num">
            <xsl:with-param name="hex">
                <xsl:value-of select="fn:substring($stroke, 4, 2)"/>
            </xsl:with-param></xsl:call-template>
        <xsl:text>,</xsl:text>
        <xsl:call-template name="hex2num">
            <xsl:with-param name="hex">
                <xsl:value-of select="fn:substring($stroke, 6, 2)"/>
            </xsl:with-param></xsl:call-template>
        <xsl:text>); stroke-width: </xsl:text>
        <xsl:value-of select="$stroke-width"/>
        <xsl:text>; stroke-dasharray: </xsl:text>
        <xsl:choose>
            <xsl:when test="$stroke-dasharray"><xsl:value-of select="$stroke-dasharray"/>;</xsl:when>
            <xsl:otherwise>solid;</xsl:otherwise>
        </xsl:choose>
        <xsl:text>; stroke-linecap: </xsl:text>
        <xsl:value-of select="$stroke-linecap"/>
        <xsl:text>; opacity: </xsl:text>
        <xsl:value-of select="$stroke-opacity"/>
        <xsl:text>;' y1='10' x2='58' y2='10' x1='0'/&gt;&lt;/g&gt;&lt;/svg&gt;");</xsl:text>
        <xsl:text>&#xa;&#x9;margin-right: 10px;</xsl:text>
        <xsl:text>&#xa;&#x9;}</xsl:text>
    </xsl:template>
    <xd:doc>
        <xd:desc/>
        <xd:param name="hex"/>
        <xd:param name="num"/>
        <xd:param name="MSB"/>
        <xd:param name="value"/>
        <xd:param name="result"/>
    </xd:doc>
    <xsl:template name="hex2num">
        <xsl:param name="hex"/>
        <xsl:param name="num" select="0"/>
        <xsl:param name="MSB" select="translate(substring($hex, 1, 1), 'abcdef', 'ABCDEF')"/>
        <xsl:param name="value" select="string-length(substring-before('0123456789ABCDEF', $MSB))"/>
        <xsl:param name="result" select="16 * $num + $value"/>
        <xsl:choose>
            <xsl:when test="string-length($hex) > 1">
                <xsl:call-template name="hex2num">
                    <xsl:with-param name="hex" select="substring($hex, 2)"/>
                    <xsl:with-param name="num" select="$result"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$result"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>