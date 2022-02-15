<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:kl="www.kl.nl"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <!-- Folder waar de basis svg's in staan -->
    <xsl:param name="folder_Symbols" select="'file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Symbols'"/>
    <!-- Folder waar de SLD in staatn -->
    <xsl:param name="folder_SLD" select="'file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Symbolenbibliotheken'"/>
    <!-- Folder waar de kleurenlijst in staat -->
    <xsl:param name="folder_kleuren" select="'file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Tools'"/>
    <!-- Naam van de SLD -->
    <xsl:param name="SLD" select="'SLD_Symbolenbibliotheek_STOPTPOD_Vlaksymbolen_v1.2.0.sld'"/>
    <!-- SLD bestand openen -->
    <xsl:param name="SLD_file" select="collection(concat($folder_SLD, '?select=', $SLD, ';recurse=yes'))"/>
    <!-- Bestand met kleuren openen (tijdelijke oplossing voor de kleuren)-->
    <xsl:param name="Kleuren" select="collection(concat($folder_kleuren, '?select=', 'Lijst_kleuren.xml', ';recurse=yes'))"/>
    
    <!-- Werking -->
    <!-- Voor elke unieke OnlineResource uit het SLD bestand wordt op basis van de naam gekeken of er een basis svg is. -->
    <!-- Als er een basis svg is wordt voor elke kleur uit de lijst kleuren een svg gemaakt -->

    <!-- base van unieke bestandsnamen uit href's -->
    <xsl:template match="/">
        <xsl:variable name="online" select="$SLD_file//*[local-name()='Rule']/*[local-name()='PolygonSymbolizer'][descendant::*[local-name()='OnlineResource']]"/>
        <xsl:variable name="hrefs" select="$online//tokenize(tokenize(@xlink:href,'/')[3],'\.')[1]"/>
        <xsl:variable name="bases" >
            <xsl:for-each select="$hrefs">
                <xsl:element name="base">
                    <xsl:value-of select="substring(.,1,3)"/>
                </xsl:element>
            </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="distinct-values($bases/base/text())" mode="base"/>
    </xsl:template>
    
    <!-- haal de basis svg op -->
    <!--  -->
    <xsl:template match="." mode="base">
        <!-- eerste 3 tekens van base is gelijk base basis svg -->
        <xsl:variable name="URI" select="concat(fn:substring(.,1,3),'.svg')"/>
        <xsl:variable name="basis_svg" select="fn:document(concat($folder_Symbols,'/basis_svg/', $URI))"/>
        
        <!-- lijst kleuren ophalen -->
        <xsl:variable name="kleur_code" select="$Kleuren/kleuren/kleur"/>
        
        <xsl:if test="$basis_svg">
            <xsl:apply-templates select="$kleur_code" mode="base_svg">
                <xsl:with-param name="basis_svg" select="$basis_svg"/>
            </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    
    <!-- voor elke kleur een nieuwe svg maken -->
    <xsl:template match="." mode="base_svg">
        <xsl:param name="basis_svg"/>
        <xsl:variable name="kleur_code" select="./kleurcode/text()"/>
        <xsl:variable name="symbool_code" select="./symboolcode/text()"/>
        <xsl:variable name="basis_naam" select="tokenize(subsequence(reverse(tokenize(fn:base-uri($basis_svg), '/')), 1, 1),'\.')[1]"/>
        
        <xsl:variable name="naam" select="concat($basis_naam,$symbool_code)"/>
        <xsl:variable name="URI" select="concat($folder_Symbols,'/SVG/',$naam,'.svg')"/>
        <xsl:result-document href="{$URI}">
            <xsl:apply-templates select="$basis_svg" mode="svg">
                <xsl:with-param name="kleur" select="."/>
                <xsl:with-param name="naam" select="$naam"/>
            </xsl:apply-templates>
        </xsl:result-document>
    </xsl:template>
    <!-- kopie van basis svg -->
    <xsl:template match="@*|node()" mode="svg">
        <xsl:param name="kleur"/>
        <xsl:param name="naam"/>
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" mode="svg">
                <xsl:with-param name="kleur" select="$kleur"/>
                <xsl:with-param name="naam" select="$naam"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <!--  -->
    <xsl:template match="@id" mode="svg">
        <xsl:param name="kleur"/>
        <xsl:param name="naam"/>
        <xsl:attribute name="id">
            <xsl:value-of select="$naam"/>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@fill" mode="svg">
        <xsl:param name="kleur"/>
        <xsl:if test=".!='none'">
            <xsl:attribute name="fill">
                <xsl:value-of select="$kleur/kleurcode/text()"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="@stroke" mode="svg">
        <xsl:param name="kleur"/>
        <xsl:if test=".!='none'">
            <xsl:attribute name="stroke">
                <xsl:value-of select="$kleur/kleurcode/text()"/>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>