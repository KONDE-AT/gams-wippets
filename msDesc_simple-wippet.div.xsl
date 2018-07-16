<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Wippet to display basic metadata from teiHeader and msDesc</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>To use on the level of html:div.</p>
            <p>The wippet displays basic information from the TEI msDesc.</p>
            <p>Example implementation: http://glossa.uni-graz.at/o:epistles.1400</p>
        </desc>
    </doc>
    
    
    
    <xsl:template name="msDesc_simple">
        
        <xsl:for-each select="//t:msIdentifier">
            
                <h2><xsl:if test="t:msName">
                    <xsl:apply-templates select="t:msName[1]"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                    
                    <xsl:apply-templates select="t:idno"/>
                    <xsl:text>, </xsl:text>
                    <xsl:apply-templates select="t:repository"/>
                    <xsl:text>, </xsl:text>
                    <xsl:apply-templates select="t:settlement"/>
                    <xsl:text>, </xsl:text>
                    <xsl:apply-templates select="t:country"/>
                </h2>
                
                
        </xsl:for-each>
        
        <h3>Texts available:</h3>
        <xsl:for-each select="//t:msContents/t:msItem">
            <p>
                <xsl:apply-templates select="t:title"/>
                    <br/>
                
                <strong>
                    <xsl:text>Incipit: </xsl:text>
                </strong>
                <xsl:choose><xsl:when test="t:incipit">
                    <xsl:apply-templates select="t:incipit"/>
                </xsl:when>
                    <xsl:otherwise><xsl:text>None</xsl:text></xsl:otherwise>
                </xsl:choose>
                <br/>
                <strong>
                    <xsl:text>Explicit: </xsl:text>
                </strong>
                <xsl:choose><xsl:when test="t:explicit">
                    <xsl:apply-templates select="t:explicit"/>
                </xsl:when>
                <xsl:otherwise><xsl:text>None</xsl:text></xsl:otherwise>
                </xsl:choose>
                
            </p>  
            
        </xsl:for-each>
    </xsl:template>
    
    
    
    <!-- END choice_popover-wippet -->
    
    
    
    
    
    
</xsl:stylesheet>


