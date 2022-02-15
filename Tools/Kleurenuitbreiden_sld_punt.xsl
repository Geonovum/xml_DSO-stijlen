<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:se="http://www.opengis.net/se"
    xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
    xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <!-- De SLD voor vlakken uitbreiden met nieuwe kleuren
         - voeg eerst de kleuren met code toe aan de lijst kleuren xml
    -->

    <!-- file:// + volledig pad naar xml met kleuren (kleuren/kleur/symboolcode + kleurcode) -->
    <xsl:param name="kleuren"
        select="document('file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Tools/Lijst_kleuren.xml')"/>

    <!-- Idenity template -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>

    <!-- Na de laatste Rule nieuwe kleuren invoegen -->
    <xsl:template match="se:Rule[position()=last()]">
        <xsl:copy-of select="."/>
        <xsl:variable name="last" select="last()"/>
        <xsl:variable name="rule" select="."/>
        <xsl:variable name="laatste"
            select="number(substring(./se:Name/text(), string-length(./se:Name/text()) - 1))"/>
        <xsl:for-each select="$kleuren//kleur[number(symboolcode) > $laatste]">
            <xsl:apply-templates select="$rule" mode="kleur">
                <xsl:with-param name="kleur" select="."/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <!-- gebruik de laatste Rule als template -->
    <xsl:template match="se:Rule" mode="kleur">
        <xsl:param name="kleur"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="rule">
                <xsl:with-param name="kleur" select="$kleur"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <!-- Identity template voor Rule -->
    <xsl:template match="node() | @*" mode="rule">
        <xsl:param name="kleur"/>
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="rule">
                <xsl:with-param name="kleur" select="$kleur"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <!-- Vervang de symboolcode -->
    <xsl:template match="se:Name" mode="rule">
        <xsl:param name="kleur"/>
        <xsl:element name="se:Name">
            <xsl:value-of
                select="concat(substring(./text(), 0, string-length(.) - 1), $kleur/symboolcode)"/>
        </xsl:element>
    </xsl:template>

    <!-- Vervang de kleurcode in Filter -->
    <xsl:template match="ogc:Literal" mode="rule">
        <xsl:param name="kleur"/>
        <xsl:element name="ogc:Literal">
            <xsl:value-of
                select="concat(substring(./text(), 0, string-length(.) - 1), $kleur/symboolcode)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="se:SvgParameter[@name = 'fill']" mode="rule">
        <xsl:param name="kleur"/>
        <xsl:element name="se:SvgParameter">
            <xsl:attribute name="name">fill</xsl:attribute>
            <xsl:value-of select="$kleur/kleurcode"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
