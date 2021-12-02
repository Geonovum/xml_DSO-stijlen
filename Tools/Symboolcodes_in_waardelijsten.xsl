<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sld="http://www.opengis.net/sld"
    xmlns:se="http://www.opengis.net/se"
    exclude-result-prefixes="xs" version="2.0" >

    <xsl:output indent="yes" method="xml"/>

    <xsl:param name="waardelijst"
        select="document('file:///F:/DSO/Geonovum/GitHub/xml_DSO-stijlen/Symbolisatietabellen/waardelijsten 2.1.0.xml')"/>


    <xsl:template match="node() | @*">
        <xsl:apply-templates select="node() | @*"/>
    </xsl:template>


    <xsl:template match="sld:StyledLayerDescriptor">
        <xsl:text disable-output-escaping="yes">&#xa;&lt;?xml-stylesheet type="text/css" href="../CSS/Lijst_waarden_bij_symboolcodes.css"?&gt;&#xa;</xsl:text>
        <xsl:element name="symboolcodes">
            <xsl:apply-templates select="//*[local-name() = 'Rule']/*[local-name() = 'Name']"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="se:Name">
        <xsl:variable name="code" select="./text()"/>
        <xsl:element name="symboolcode">
            <xsl:element name="vlak">
                <xsl:attribute name="id" select="$code"/>
                <xsl:value-of select="$code"/>
            </xsl:element>
            <xsl:element name="waardelijsten">
                <xsl:choose>
                    <xsl:when test="count($waardelijst//waardelijst/waarden/waarde[symboolcode/vlak/@id = $code][1])>0">
                        <xsl:apply-templates select="$waardelijst//waardelijst/waarden/waarde[symboolcode/vlak/@id = $code][1]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="term"/>
                        <xsl:element name="waarden"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="waarde">
        <xsl:variable name="code" select="./symboolcode/vlak/text()"/>
        <xsl:element name="term">
            <xsl:value-of select="./../../term/text()"/>
        </xsl:element>
        <xsl:element name="waarden">
            <xsl:apply-templates
                select="./../waarde/symboolcode[vlak/@id = $code]"
            />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="symboolcode">
        <xsl:element name="label">
            <xsl:value-of select="./../term/text()"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
