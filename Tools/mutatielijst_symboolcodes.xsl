<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:output indent="yes" method="xml"/>

    <xsl:template match="waardelijsten">
        <xsl:text disable-output-escaping="yes">&#xa;&lt;?xml-stylesheet type="text/css" href="../CSS/Mutatielijst_symboolcodes.css"?&gt;&#xa;</xsl:text>
        <xsl:element name="functiegroepen">
            <xsl:element name="head">
                <xsl:element name="groep_kop">Groep</xsl:element>
                <xsl:element name="waarde_kop">Waarde</xsl:element>
                <xsl:element name="huidig_kop">Huidig</xsl:element>
                <xsl:element name="voorstel_kop">Voorstel</xsl:element>
                <xsl:element name="IMRO_kop">IMRO</xsl:element>
            </xsl:element>
            <xsl:apply-templates select="./waardelijst/term">
                <xsl:sort select="term"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>

    <xsl:template match="term">
        <xsl:element name="groep">
            <xsl:copy-of select="."/>
            <xsl:element name="waarden">
                <xsl:apply-templates select="./../waarden/waarde"/> 
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="waarde">
        <xsl:element name="waarde">
            <xsl:copy-of select="./label"/>
            <xsl:element name="huidig">
                <xsl:element name="symboolcode">
                    <xsl:copy-of select="./symboolcode/vlak"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="voorstel">
                <xsl:element name="symboolcode">
                    <xsl:element name="vlak">
                        <xsl:attribute name="id"/>
                        <xsl:text></xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <xsl:element name="IMRO">
                <xsl:element name="symboolcode">
                    <xsl:element name="vlak">
                        <xsl:attribute name="id"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
