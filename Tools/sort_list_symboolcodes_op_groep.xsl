<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:param name="termen" select="//distinct-values(symboolcode/waardelijsten/term)"/>
    
    <xsl:template match="symboolcodes">
        <xsl:text disable-output-escaping="yes">&#xa;&lt;?xml-stylesheet type="text/css" href="../CSS/Lijst_waarden_bij_symboolcodes_groep.css"?&gt;&#xa;</xsl:text>
        
        <xsl:element name="functiegroepen">
            <xsl:apply-templates select="//term[text()!='']">
                <xsl:sort select="text()"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="term">
    <xsl:element name="symboolcode">
        <xsl:copy-of select="./../../vlak"></xsl:copy-of>
            <xsl:copy-of select="."/>
            <xsl:copy-of select="./following-sibling::waarden[1]"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>