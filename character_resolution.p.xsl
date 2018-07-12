<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <!-- Titel und Name der Datei kannst du ändern, du kannst die Beschreibung auch auf Deutsch machen -->
            <h1>Character resolution</h1>
            <p>helmut.klug@uni-graz.at</p>
            <p>To use on the level of html:p.</p>
            <p></p>
            <p>Example implementation: ???</p>
            <p>Dependencies: ???</p>
        </desc>
        <param><b>url</b>: if the tei:charDecl is in an external document, provide the URL as parameter</param>
    </doc>
    
   
        
        <xsl:template match="t:g">
            <!-- Zusätzlicher Kommentar -->
            <xsl:param name="url"><xsl:text></xsl:text></xsl:param>
            <xsl:variable name="zeichenID">
                <xsl:value-of select="substring(@ref,2)"/>
            </xsl:variable>
            
            <xsl:choose>
                <xsl:when test="$url=''">
                    <xsl:value-of select="preceding::t:encodingDesc/child::t:charDecl/child::t:glyph[@xml:id=$zeichenID]/child::t:mapping[@subtype='html_entity']"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="doc('http://ressource_url')//t:glyph[@xml:id=$zeichenID]/child::t:mapping[@subtype='html_entity']"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>
        
    
    
    
</xsl:stylesheet>