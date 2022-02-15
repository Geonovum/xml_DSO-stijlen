<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:template match="symboolcodes">
        <xsl:text disable-output-escaping="yes">&#xa;&lt;?xml-stylesheet type="text/css" href="../CSS/Lijst_waarden_bij_symboolcodes.css"?&gt;&#xa;</xsl:text>
        <xsl:copy>
            <xsl:apply-templates select="./symboolcode">
                <xsl:sort select="./vlak/substring(@id,string-length(@id)-1,2)"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="symboolcode">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>