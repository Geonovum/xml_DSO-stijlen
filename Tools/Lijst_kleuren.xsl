<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <!-- Lijst kleuren uit een SLD
         - SvgParameter waarvan fill-opacity niet 0 is
         - laatste 2 cijfers uit Name van Rule = symboolcode
         - fill = kleurcode (3-delige hexadecimale code: rood, groen en blauw) -->
    <xsl:template match="/">
        <xsl:element name="kleuren">
            <xsl:variable name="reeks" select="distinct-values(//*[local-name()='Rule'][.//*[local-name()='SvgParameter'][@name='fill-opacity' and text()!='0']]//*[local-name()='SvgParameter'][@name='fill']/concat(fn:substring(./../../*[local-name()='Name'],fn:string-length(./../../*[local-name()='Name'])-1),'|',text()))"/>
            <xsl:for-each select="$reeks">
                <xsl:element name="kleur" inherit-namespaces="yes" namespace="">
                    <xsl:element name="symboolcode" inherit-namespaces="yes" namespace="">
                        <xsl:value-of select="fn:tokenize(.,'\|')[1]"/>
                    </xsl:element>
                    <xsl:element name="kleurcode" inherit-namespaces="yes" namespace="">
                        <xsl:value-of select="fn:tokenize(.,'\|')[2]"/>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>