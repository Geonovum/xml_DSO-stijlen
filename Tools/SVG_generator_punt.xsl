<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <!-- Folder waar de SLD en de basis svg's in staan -->
    <xsl:param name="folder" select="'file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Symbolenbibliotheken/SLD'"/>
    <!-- Naam van de SLD -->
    <xsl:param name="SLD" select="'../SLD_Symbolenbibliotheek_STOPTPOD_Puntsymbolen_v1.0.1.sld'"/>
    <!-- optioneel een specifieke groep fts gebruiken -->
    <xsl:param name="fts" select="''"/>
    <!-- Werking -->
    <!-- Voor elke FeatureTypeStyle uit het SLD bestand wordt op basis van de naam gekeken of er een basis svg is. -->
    <!-- Als er een basis svg is wordt voor elke Rule een svg gemaakt met dezelfde naam en met de opmaak uit die Rule -->
    
    <xsl:template match="/">
        <xsl:apply-templates select="collection(concat($folder, '?select=', $SLD, ';recurse=yes'))" mode="sld"/>
    </xsl:template>
    <!-- loop door FeatureTypeStyles, de naam komt overeen met de basis svg naam -->
    <xsl:template match="." mode="sld">
        <!-- iedere fts of een specifieke groep -->
        <xsl:choose>
            <xsl:when test="$fts=''">
                <xsl:apply-templates select="/*[local-name()='StyledLayerDescriptor']/*[local-name()='NamedLayer']/*[local-name()='UserStyle']/*[local-name()='FeatureTypeStyle']" mode="fts"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="/*[local-name()='StyledLayerDescriptor']/*[local-name()='NamedLayer']/*[local-name()='UserStyle']/*[local-name()='FeatureTypeStyle']/*[local-name()='Name'][fn:contains(text(),$fts)]/.." mode="fts"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- haal de basis svg op -->
    <xsl:template match="." mode="fts">
        <xsl:variable name="naam" select="./*[local-name()='Name']/text()"/>
        <xsl:variable name="URI" select="concat($naam,'.svg')"/>
        <xsl:variable name="basis_svg" select="fn:document(concat($folder,'/basis_svg/', $URI))"/>
        <xsl:if test="$basis_svg">
            <xsl:apply-templates select="./*[local-name()='Rule']" mode="basis_svg">
                <xsl:with-param name="basis_svg" select="$basis_svg"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    
    <!-- op basis van rule nieuwe svg maken -->
    <xsl:template match="." mode="basis_svg">
        <xsl:param name="basis_svg"/>
        <xsl:variable name="naam" select="./*[local-name()='Name']"/>
        <xsl:variable name="URI" select="concat($folder,'/SVG/',$naam,'.svg')"/>
        <xsl:result-document href="{$URI}">
            <xsl:apply-templates select="$basis_svg" mode="svg">
                <xsl:with-param name="rule" select="."/>
            </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>
    <!-- kopie van basis svg -->
    <xsl:template match="@*|node()" mode="svg">
        <xsl:param name="rule"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="svg">
                <xsl:with-param name="rule" select="$rule"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <!--  -->
    <xsl:template match="@id" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="id"><xsl:value-of select="$rule/*[local-name()='Name']/text()"/></xsl:attribute>
    </xsl:template>

    <xsl:template match="@fill" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="fill"><xsl:value-of select="$rule/*[local-name()='PointSymbolizer']/*[local-name()='Graphic']/*[local-name()='Mark']/*[local-name()='Fill']/*[local-name()='SvgParameter'][@name='fill']/text()"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@fill-opacity" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="fill-opacity"><xsl:value-of select="$rule/*[local-name()='PointSymbolizer']/*[local-name()='Graphic']/*[local-name()='Mark']/*[local-name()='Fill']/*[local-name()='SvgParameter'][@name='fill-opacity']/text()"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@stroke" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="stroke"><xsl:value-of select="$rule/*[local-name()='PointSymbolizer']/*[local-name()='Graphic']/*[local-name()='Mark']/*[local-name()='Stroke']/*[local-name()='SvgParameter'][@name='stroke']/text()"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@stroke-width" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="stroke-width"><xsl:value-of select="$rule/*[local-name()='PointSymbolizer']/*[local-name()='Graphic']/*[local-name()='Mark']/*[local-name()='Stroke']/*[local-name()='SvgParameter'][@name='stroke-width']/text()"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@stroke-opacity" mode="svg">
        <xsl:param name="rule"/>
        <xsl:attribute name="stroke-opacity"><xsl:value-of select="$rule/*[local-name()='PointSymbolizer']/*[local-name()='Graphic']/*[local-name()='Mark']/*[local-name()='Stroke']/*[local-name()='SvgParameter'][@name='stroke-opacity']/text()"/></xsl:attribute>
    </xsl:template>
    
</xsl:stylesheet>