<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Popover Wippet for tei:choice and similar elements</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>To use on the level of html:div und html:p.</p>
            <p>The template choice_popover transforms TEI element pairs (such as tei:abbr/tei:expan or tei:reg/tei:orig into a Twitter Bootstrap (tested with Bootstrap 3.3.5) popover event.
               These TEI element pairs are ususally nested within a tei:choice and the template choice_popover has to be </p>
            <p>Example implementation: http://glossa.uni-graz.at/o:epistles.1400</p>
            <p>Dependencies: Requires Twitter Bootstrap (3+), the JS Code in choice_popover-wippet.p.js has to be included.</p>
        </desc>
        <param><b>in_trans</b>: an element name. The content of this element will be displayed in the transcription e.g. tei:abbr</param>
        <param><b>in_popover</b>: an element name. The content of this element will be displayed in the popover e.g. tei:abbr</param>
    </doc>
    
    
    <xsl:template match="t:choice[t:abbr and t:expan]" mode="transcription">
        <!-- this example wippet is used for the element pair tei:abbr/tei:expan 
            to use different element change the element names in the square brackets, e.g. [t:abbr and t:expan] => [t:am and t:ex] and change the @select on xsl:with-param below
            besides for tei:choice the wippet can also be used for tei:subst -->
        
        <xsl:call-template name="choice_popover">
            <!--Param in_trans: element name-->
            <!--Param in_popover: element name-->
            <!-- suggested element pairs following the TEI guidelines: tei:am/tei:ex tei:abbr/tei:expan tei:reg/tei:orig, etc.  -->
            <xsl:with-param name="in_trans" select="t:abbr"></xsl:with-param>
            <xsl:with-param name="in_popover" select="t:expan"></xsl:with-param>
        </xsl:call-template>
        
    </xsl:template>
    
    
    <xsl:template name="choice_popover">
        <!--Param in_trans: element name-->
        <!--Param in_popover: element name-->
        <xsl:param name="in_trans"></xsl:param>
        <xsl:param name="in_popover"></xsl:param>
        
        <a href="" data-toggle="popover" style="color:blue">
            <!-- Bootstrap popover requires an @data-toggle and @data-content, https://v4-alpha.getbootstrap.com/components/popovers/ -->
            <xsl:attribute name="class">
                <xsl:text>tei-</xsl:text>
                <xsl:value-of select="local-name($in_trans)"/>
            </xsl:attribute>
            <xsl:attribute name="data-content">
                <xsl:text>&lt;div&gt;</xsl:text>
                <xsl:apply-templates select="$in_popover" mode="#current" />
                <xsl:text>&lt;/div&gt;</xsl:text>
            </xsl:attribute>
            
            <xsl:apply-templates select="$in_trans" mode="#current"/>
            
        </a>
    </xsl:template>
    
    
    
    <xsl:template match="t:ex" mode="transcription">
        <!-- if the popover is used for abbreviations, the expanded part will be set into italics -->
        <xsl:text>&lt;i&gt;</xsl:text>
        <xsl:apply-templates mode="#current"/>
        <xsl:text>&lt;/i&gt;</xsl:text>
    </xsl:template>
    
    
    
</xsl:stylesheet>