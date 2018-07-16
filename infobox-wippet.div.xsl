<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1" 
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all" 
    xmlns:oai="http://www.openarchives.org/OAI/2.0/">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Wippet to display basic metadata from teiHeader and msDesc</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>To use on the level of html:div.</p>
            <p>The infobox-wippet displays basic metadata about an object and covers the elements of the minimum TEI/LIDO GAMS metadata/header (Template names: tei_meta_template.xml and the lido_meta_template.xml).</p>
            <p>For all TEI and LIDO documents published with the GAMS the minimum teiHeader/LIDO metadata present in the templates have to be provided.</p>
            <p>For the display of the Handle permalink the OAI namespace is necessary: xmlns:oai="http://www.openarchives.org/OAI/2.0/"</p>
            <p>Code for Handle display provided by Elisabeth Steiner.</p>
        </desc>
    </doc>
    
    
  <!--  <xsl:template match="/">
        <html>
            <head><title>t</title>
                <meta charset="UTF-8"></meta>
            <style>
                #info_box_tei{
                padding: 10px;
                border: 1px solid black;
                margin: 10px;
                }
                .info_label{
                font-weight: bold;
                color: #00BFFF;
                }
                #info_box_lido{
                padding: 10px;
                border: 1px solid red;
                margin: 10px;
                }
            </style>
            </head>
        
        <body>
        
            <xsl:call-template name="info_box_tei"></xsl:call-template>
            <xsl:call-template name="info_box_lido"></xsl:call-template>
        </body>
        </html>
    </xsl:template>-->
    
    
    
    <!-- Begin TEI info box -->
    
    
    
    <xsl:template name="info_box_tei">
        <xsl:variable name="pid" select="//t:publicationStmt/t:idno[type='PID']"/>
        <div id="info_box_tei">
           
        <xsl:for-each select="//t:fileDesc">
            <xsl:apply-templates select="t:titleStmt/*" mode="info_box_tei"></xsl:apply-templates>
            
            
            
            <p><span class="info_label">Zitiervorschlag: </span><xsl:value-of select="t:titleStmt/t:author"/>, <xsl:value-of select="t:titleStmt/t:title"/>, bearb. v. 
                <xsl:for-each select="t:titleStmt/t:respStmt">
                    <xsl:if test="preceding-sibling::t:resp"><xsl:text>, </xsl:text></xsl:if>
                    <xsl:apply-templates select="t:name | t:persName" mode="info_box_tei"/>
                </xsl:for-each>
                
                <xsl:if test="t:seriesStmt">
                    <xsl:text>, </xsl:text><xsl:value-of select="t:seriesStmt/t:title"/>
                </xsl:if>
                
                <xsl:text>, </xsl:text>
                <xsl:value-of select="t:publicationStmt/t:publisher"/>                
                <xsl:text>.</xsl:text>
            
            
            </p>
            
            <xsl:if test="../t:revisionDesc">
               
                    <!-- requires that the latest revision is the first child of revisionDesc -->
                <p><span class="info_label">Zuletzt geändert: </span><xsl:value-of select="t:change[1]/@wenn"/></p>
                    
            </xsl:if>
            
            <p><span class="info_label">Permalink: </span><xsl:text>http://gams.uni-graz.at/</xsl:text><xsl:value-of select="t:publicationStmt/t:idno[type='PID']"/></p>
            
            
            <!-- Ausgabe des Handle Permalink -->
            <xsl:if
                test="starts-with(document(concat('/', $pid, '/RELS-EXT'))//oai:itemID, 'hdl:')">
                
                <xsl:variable name="handle" select="substring-after(document(concat('/', $pid, '/RELS-EXT'))//oai:itemID, 'hdl:')"></xsl:variable>
                
                <p><span class="info_label">Handle PID: </span>
                    <xsl:element name="a">
                        <xsl:attribute name="href">
                            <xsl:text>hdl.handle.net/</xsl:text>
                            <xsl:value-of select="$handle" />
                        </xsl:attribute>
                        <xsl:value-of select="$handle" />
                    </xsl:element>
                    </p>
            </xsl:if>
            
            
            
            <p><span class="info_label">Verfügbarkeit: </span>
                <xsl:element name="a">
                    <xsl:attribute name="href" select="t:publicationStmt/t:availability/t:licence/@target"></xsl:attribute>
                
                <xsl:value-of select="t:publicationStmt/t:availability/t:licence"/></xsl:element></p>
               
        </xsl:for-each>
        
            
        </div>
    </xsl:template>
    
    
    <xsl:template  match="t:title" mode="info_box_tei">
        <xsl:choose>
            <xsl:when test="@type='sub'">
                <span class="info_label">Untertitel: </span><xsl:value-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <span class="info_label">Titel: </span><xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template  match="t:author" mode="info_box_tei">
        <p><span class="info_label"><xsl:text>Autor: </xsl:text></span><xsl:apply-templates mode="info_box_tei"></xsl:apply-templates></p>
    </xsl:template>
    
    <xsl:template match="t:respStmt" mode="info_box_tei">
        <p><span class="info_label">Zuständigkeit: </span><xsl:apply-templates mode="info_box_tei"></xsl:apply-templates></p>
    </xsl:template>
    
    <xsl:template match="t:editor | t:principal" mode="info_box_tei">
        <p><span class="info_label">Herausgegeben von: </span><xsl:apply-templates mode="info_box_tei"></xsl:apply-templates></p>
    </xsl:template>
    
    <xsl:template  match="t:name" mode="info_box_tei">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template  match="t:persName" mode="info_box_tei">
        <xsl:value-of select="t:forename"/><xsl:text> </xsl:text><xsl:value-of select="t:surname"/>
    </xsl:template>
    
    <!-- End TEI info box -->
    
    
    
    <!-- Begin LIDO info box -->
    
    <xsl:template name="info_box_lido">
        
        <div id="info_box_lido">
            
            <xsl:for-each select="/lido:lido/lido:descriptiveMetadata/lido:objectRelationWrap//lido:objectNote[@lido:type='name']">
                
                <p><span class="info_label">Projekttitel: </span><xsl:value-of select="."/></p>
                
            </xsl:for-each>
            
            
            <xsl:for-each select="/lido:lido/lido:descriptiveMetadata/lido:objectRelationWrap//lido:objectNote[@lido:type='resp']">
                
                <p><span class="info_label">Zuständigkeit: </span><xsl:value-of select="."/></p>
                
            </xsl:for-each>
            
            
            <p><span class="info_label">Permalink: </span><xsl:text>https://gams.uni-graz.at/</xsl:text><xsl:value-of select="lido:lido/lido:administrativeMetadata[1]/lido:recordWrap/lido:recordID"/></p>
            
            <p><span class="info_label">Lizenz: </span><xsl:element name="a">
                <xsl:attribute name="href" select="/lido:lido/lido:administrativeMetadata[1]/lido:recordWrap/lido:recordRights/lido:creditLine[@lido:label='uri']"></xsl:attribute>
                <xsl:value-of select="/lido:lido/lido:administrativeMetadata[1]/lido:recordWrap/lido:recordRights/lido:creditLine[@lido:label='text']"/>
            </xsl:element></p>
            
           
            
            
        </div>
    </xsl:template>
    
    
   
    
    
    
    <!-- End LIDO info box -->
    
    
    
    
</xsl:stylesheet>


