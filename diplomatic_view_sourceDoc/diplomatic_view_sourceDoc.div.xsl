<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Diplomatic View Wippet</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>To use on the level of html:div and html:article.</p>
            <p>The wippet implements a basic diplomatic view presentation for TEI documents encoded using the embedded transcription method (tei:sourceDoc/tei:surface/tei:zone/tei:line)</p>
            <p>Example implementation: http://glossa.uni-graz.at/o:epistles.1400</p>
            <p>Dependencies: Requires the wippet choice_popover-wippet. The XSLT @mode in the choice_popover-wippet might need to be changed!</p>
            <p>Dependencies: Requires diplomatic_view_sourceDoc.div.css to be included.</p>
            <p>Dependencies: Requires Twitter.</p>
        </desc>
    </doc>
    
    <xsl:template name="diplomatic_view">
        
        <div data-name="transcription">
                <xsl:apply-templates select="//t:sourceDoc" mode="transcription"></xsl:apply-templates>
        </div>
        
    </xsl:template>
    
    
    <xsl:template match="t:*" mode="transcription">
        <!-- default for all TEI elements with @mode=transcription -->
           <xsl:apply-templates mode="#current"/>
    </xsl:template>
 
   
    <xsl:template match="t:surfaceGrp | t:surface | t:zone" mode="transcription">
        <!-- transforms tei:surfaceGrp. tei:surface, tei:zone elements into html:div elements have a @class=tei-surface /@class=tei-surfaceGrp/ @class=tei-zone  -->
        <!-- if an @type is present its value is added after an underscore (e.g. @class=tei-zone_folio) -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:if test="@type">
                <xsl:text>_</xsl:text>
                <xsl:value-of select="@type"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:element name="div">
            <xsl:attribute name="class" select="$classValue"/>
                
             
            <xsl:if test="@facs">
                <!-- If the @facs is used to provide an image URI the statements with the xsl:if have to be revised -->
                <xsl:variable name="imgId" select="substring-after(@facs, '#')"/>
                
                <xsl:variable name="imgUrl" select="//t:graphic[@xml:id=$imgId]/@url"/>
                
                <a href="{$imgUrl}"><xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="$imgUrl"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">
                        <xsl:text>tei-graphic</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="style">
                        <xsl:text>width:300px</xsl:text>
                    </xsl:attribute>
                </xsl:element></a>
                
            </xsl:if>
                
           <xsl:apply-templates mode="#current"/>
            
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="t:sourceDoc//t:graphic" mode="transcription">
        <!-- transforms tei:graphic elements within the transcription, the html:img element has a @class=tei-graphic -->
            <xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:value-of select="@url"/>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>tei-graphic</xsl:text>
                </xsl:attribute>
            </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="t:line" mode="transcription">
        <!-- transforms tei:line to an html:div with a @class=tei-line, the line number is either generated from tei:@n or from the position of the line -->
        <!-- the html:span@class=line_number contains the line number, the html:span@class=line_text the transcription -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:if test="@type">
                <xsl:text>_</xsl:text>
                <xsl:value-of select="@type"/>
            </xsl:if>
        </xsl:variable>
        
        <div>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <span class="line_number">
                <xsl:choose>
                    <xsl:when test="@n">
                        <xsl:value-of select="@n"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="position()"/>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:text>.</xsl:text>
            </span>
            <span class="line_text">
               <xsl:apply-templates mode="#current"/>
            </span>
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </div>
    </xsl:template>
    
    
    <!-- ADDITIONS AND DELETIONS -->
    
    <xsl:template match="t:add" mode="transcription">
        <!-- transforms tei:add to an html:ins with a @class=tei-add, if an @place is present its value is added after an underscore (@class=tei-add_above) -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:if test="@place"><xsl:text>_</xsl:text>
                <xsl:value-of select="@place"/></xsl:if>
        </xsl:variable>
        <ins>
        <xsl:choose>
            <xsl:when test="@place = 'above'">
                <sup>
                    <xsl:attribute name="class" select="$classValue"/>
                   <xsl:apply-templates mode="#current"/>
                </sup>
            </xsl:when>
            <xsl:when test="@place = 'below'">
                <sub>
                    <xsl:attribute name="class" select="$classValue"/>
                   <xsl:apply-templates mode="#current"/>
                </sub>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="class" select="$classValue"/>
                   <xsl:apply-templates mode="#current"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        </ins>
    </xsl:template>
    
    <xsl:template match="t:del" mode="transcription">
        <!-- transforms tei:del to html:del with a @class=tei-del -->
        <del>
            <xsl:attribute name="class">
            <xsl:text>tei-</xsl:text>
                        <xsl:value-of select="local-name()"/>                        
                    </xsl:attribute>
           <xsl:apply-templates mode="#current"/>
                
        </del>
    </xsl:template>
    

    <!-- EDITORIAL CORRECTIONS -->
    
    <xsl:template match="t:sic | t:orig" mode="transcription">
        <!-- Per default the original (not corrected) view is generated -->
        <!-- transforms the tei:sic and tei:orig to an html:span with a @class=tei-sic / tei-orig -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            
        </xsl:variable>
        <span>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:apply-templates mode="transcription"/>
        </span>
    </xsl:template>
    
    
    <!-- HIGHLIGHTING -->
    
    
    <xsl:template match="t:hi[@rend]" mode="transcription">
        <!-- transforms the tei:pc to an html:span with a @class=tei-hi, if an @rend is present its value is added after an underscore (@class=tei-hi_red) -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:if test="@rend"><xsl:text>_</xsl:text>
            <xsl:value-of select="@rend"/></xsl:if>
        </xsl:variable>
        <span>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    
    
    <!-- ABBREVIATIONS choice_popover-wippet has to be included!!! -->
    
    
    <xsl:include href="choice_popover-wippet.p.xsl"/>
   
    
    <!-- PUNCTUATION -->
    <xsl:template match="t:pc" mode="transcription">
        <!-- transforms the tei:pc to an html:span with a @class=tei-pc, if a @type is present its value is added to @data-tei-pc -->
        <span>
            <xsl:attribute name="class">
                <xsl:text>tei-</xsl:text>
                <xsl:value-of select="local-name()"/>
            </xsl:attribute>
            <xsl:if test="@type"><xsl:attribute name="data-tei-pc" select="@type">
            </xsl:attribute></xsl:if>
            
           <xsl:apply-templates mode="#current"/>
        </span>
    </xsl:template>
    
    <!-- SPACES -->
    
    
    <xsl:template match="t:space" mode="transcription">
        <!-- replaces the TEI space element with a whitespace character -->
        <xsl:text> </xsl:text>        
    </xsl:template>
 
    
</xsl:stylesheet>


