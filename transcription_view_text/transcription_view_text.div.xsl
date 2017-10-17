<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Transcription View Wippet</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>To use on the level of html:div and html:article.</p>
            <p>The wippet implements a basic transcription view presentation for TEI documents encoded using not the embedded transcription method, but instead the more common tei:text/tei:body (tei:text/tei:body/tei:div/tei:p) for transcription</p>
            <p>Dependencies: Requires the wippet choice_popover-wippet. The XSLT @mode in the choice_popover-wippet might need to be changed!</p>
            <p>Dependencies: Requires transcription_view_text.div.css to be included.</p>
            <p>Dependencies: Requires Twitter Bootstrap 3+.</p>
        </desc>
    </doc>
    
    <xsl:template name="transcription_view">
        
        <div data-name="transcription">
                <xsl:apply-templates select="//t:sourceDoc" mode="transcription"></xsl:apply-templates>
        </div>
        
    </xsl:template>
    
    
    <xsl:template match="t:*" mode="transcription">
        <!-- default for all TEI elements with @mode=transcription -->
           <xsl:apply-templates mode="#current"/>
    </xsl:template>
 
   
    <xsl:template match="t:text | t:front | t:body | t:back | t:div" mode="transcription">
        <!-- transforms tei:text, tei:body, tei:div, etc elements into html:div elements have a @class=tei-text /@class=tei-body/ @class=tei-div  -->
        <!-- if an @type is present its value is added after an underscore (e.g. @class=tei-div_folio) -->
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
                </xsl:element></a>
                
            </xsl:if>
                
           <xsl:apply-templates mode="#current"/>
            
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="t:text//t:graphic" mode="transcription">
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
    
    
    <xsl:template match="t:text//t:figure" mode="transcription">
        <!-- transforms tei:figure elements within the transcription, and groups together its child elements tei: graphic, tei:head, tei:figDesc within an html:div element has a @class=tei-figure -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:variable>
        
        <xsl:element name="div">
            <strong>
                <xsl:attribute name="class">tei-figure-head</xsl:attribute>
                <xsl:apply-templates select="t:head" mode="#current"/>
            </strong>
            <xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:value-of select="t:graphic/@url"/>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:text>tei-graphic</xsl:text>
                </xsl:attribute>
            </xsl:element>
            <p>
                <xsl:attribute name="class">tei-figDesc</xsl:attribute>
                <xsl:apply-templates select="t:figDesc" mode="#current"/>
            </p>
            
        </xsl:element>
        
    </xsl:template>
    
    
    
    <xsl:template match="t:div/t:head or t:div1/t:head" mode="transcription">
        <h1>
            <xsl:apply-templates mode="#current"/>
        </h1>
    </xsl:template>
    
    <xsl:template match="t:div2/t:head" mode="transcription">
        <h2>
            <xsl:apply-templates mode="#current"/>
        </h2>
    </xsl:template>
    
    <xsl:template match="t:div3/t:head" mode="transcription">
        <h3>
            <xsl:apply-templates mode="#current"/>
        </h3>
    </xsl:template>
    
    <xsl:template match="t:div4/t:head" mode="transcription">
        <h4>
            <xsl:apply-templates mode="#current"/>
        </h4>
    </xsl:template>
    
    <xsl:template match="t:div5/t:head" mode="transcription">
        <h5>
            <xsl:apply-templates mode="#current"/>
        </h5>
    </xsl:template>
    
    <xsl:template match="t:div6/t:head" mode="transcription">
        <h6>
            <xsl:apply-templates mode="#current"/>
        </h6>
    </xsl:template>
    
    
    
    
    
    <xsl:template match="t:p" mode="transcription">
        <!-- transforms tei:p to an html:p with a @class=tei-p, if an @xml is present it will be transformed into a html:@id -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
            
        </xsl:variable>
        
        <p>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </p>
    </xsl:template>
    
    
    <xsl:template match="t:lg" mode="transcription">
        <!-- transforms tei:lg to an html:div with a @class=tei-lg, the -->
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
               <xsl:apply-templates mode="#current"/>
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </div>
    </xsl:template>
    
    <xsl:template match="t:l" mode="transcription">
        <!-- transforms tei:l to an html:p with a @class=tei-l, by default this class will have padding on the left side (see CSS file!) -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:variable>
        
        <p>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </p>
    </xsl:template>
    
    <xsl:template match="t:list" mode="transcription">
        <!-- transforms tei:list to an html:ul/html:ol depending on the @rend, with a @class=tei-list -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="contains(@rend, 'numbered')">
                <ol>
                    <xsl:attribute name="class" select="$classValue"/>
                    <xsl:apply-templates mode="#current"/> 
                    <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:attribute name="class" select="$classValue"/>
                    <xsl:apply-templates mode="#current"/>   
                    <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
            
    </xsl:template>
    
    <xsl:template match="t:item" mode="transcription">
        <!-- transforms tei:item to an html:li with a @class=tei-item -->
        <xsl:variable name="classValue">
            <xsl:text>tei-</xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:variable>
        
        <li>
            <xsl:attribute name="class" select="$classValue"/>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
            <xsl:comment>end <xsl:value-of select="local-name()"/><xsl:text>@class=</xsl:text><xsl:value-of select="$classValue"/></xsl:comment>
        </li>
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
    
    <!-- PERSON NAMES, PLACE NAMES, ORGANISATION NAMES -->
    
    <xsl:template match="t:persName or t:placeName or t:orgName or t:name or t:rs" mode="transcription">
        <!-- basic template for encoded entities (names, person names, places, organisations, etc) within the tei:text
            if an @ref is present a hyperlink is generated with the attribute value as target -->
        <span>
            <xsl:attribute name="class">
                <xsl:text>tei-</xsl:text>
                <xsl:value-of select="local-name()"/>
            </xsl:attribute>
            
                <xsl:choose>
                    <xsl:when test="local-name() = 'name' or local-name()= 'rs'">
                        <xsl:if test="@type">
                            <xsl:attribute name="data-tei-entity" select="@type">
                        </xsl:attribute>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="data-tei-entity" select="local-name()">
                    </xsl:otherwise>
                </xsl:choose>
            
            <xsl:choose>
                <xsl:when test="@ref">
                    <xsl:element name="a">
                        <xsl:attribute name="href" select="@ref">
                        </xsl:attribute>
                        <xsl:apply-templates mode="#current"/>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="#current"/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="t:note" mode="transcription">
        <!-- basic template for encoded entities (names, person names, places, organisations, etc) within the tei:text
            if an @ref is present a hyperlink is generated with the attribute value as target -->
        <a href="" data-toggle="popover" style="color:blue">
            <!-- Bootstrap popover requires an @data-toggle and @data-content, https://v4-alpha.getbootstrap.com/components/popovers/ -->
            <xsl:attribute name="class">
                <xsl:text>tei-</xsl:text>
                <xsl:value-of select="local-name()"/>
            </xsl:attribute>
            
            <xsl:attribute name="data-content">
                <xsl:text>&lt;div&gt;</xsl:text>
                    <xsl:apply-templates select="." />
                <xsl:text>&lt;/div&gt;</xsl:text>
            </xsl:attribute>
            
            <sup style="color:red">NOTE</sup>
           
        </a>
    </xsl:template>
    
    <!-- Reference -->
    <xsl:template match="t:ref" mode="transcription">
        <!-- transforms the tei:ref to an html:a, the @target is used as the value for the html:@href -->
        <xsl:element name="a">
            <xsl:attribute name="href" select="@target">
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
 
    
</xsl:stylesheet>


