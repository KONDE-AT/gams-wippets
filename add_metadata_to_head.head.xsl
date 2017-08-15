<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget add_metadata_to_head</h1>
            <p>Ansprechperson: roman.bleier@uni-graz.at</p>
            <p>Auf Ebene html:head anzuwenden.</p>
            <p>Die Template "add_metadata_to_head" enthält eine Reihe von html:meta tags containing metadata for SEO and Bibliographic Reference Tools (z.B. Zotero) - DCTERMS und OPEN GRAPH.</p>
            <p>Das Template kann mit einer Reihe von Parametern aufgerufen werden (als Werte entweder ein Text-String oder ein XML Knoten). 
                Wird kein Parameter mitgegeben, so sind Default Werte definiert oder es wird nichts ausgegeben.</p>
            
        </desc>
        
    </doc>
    
    <xsl:template name="add_metadata_to_head">
        <!-- The template needs to be called within the html:head to add the html:meta tags to the head section. -->
        
        <!--  Es ist auch möglich für Context oder Objekt unterschiedliche Metadaten zu inkludieren. 
        	Durch abfragen des PID kann man zw. Objekt und Context unterscheiden, z.B.:
        		<xsl:choose>
						<xsl:when test="$pid != ''">
							<xsl:value-of select="concat('http://gams.uni-graz.at/', $pid)"/>
						</xsl:when>
						<xsl:otherwise>http://gams.uni-graz.at/context:???</xsl:otherwise>
					</xsl:choose>
         -->
        <xsl:param name="type">website</xsl:param>
        <xsl:param name="url">http://gams.uni-graz.at/context:gams</xsl:param>
        <xsl:param name="image">https://static.uni-graz.at/fileadmin/_processed_/e/d/csm_gams-start1_4ebc8f634e.jpg</xsl:param>
        <xsl:param name="publisher" select="//t:publicationStmt//t:authority"/>
        <xsl:param name="author" select="//t:titleStmt//t:author"/>
        <xsl:param name="editor" select="//t:respStmt//t:persName"/>
        <xsl:param name="description" select="//t:editionStmt"/>
        <xsl:param name="license" select="//t:availability/t:licence"/>
        <xsl:param name="language" select="//t:text/@xml:lang"/>
        <xsl:param name="yearOfPublication" select="//t:pulicationStmt//t:date"></xsl:param>
        <xsl:param name="title" select="//t:titleStmt//t:title"></xsl:param>
        
        <meta name="google" content="notranslate" />
        
        <!-- DCTERMS -->
        <meta name="dcterms.type" content="{$type}"></meta>
        <meta name="dcterms.title" content="{$title}"></meta>
        <meta name="dcterms.publisher" content="{$publisher}"></meta>
        <meta name="dcterms.issued" content="{$yearOfPublication}"></meta>
        <meta name="dcterms.description" content="{$description}"></meta>
        <meta name="dcterms.license" content="{$license}"></meta>
        <meta name="dcterms.language" content="{$language}"></meta>
        
        <xsl:for-each select="$author">
            <meta name="dcterms.creator">
                <xsl:attribute name="content">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </meta>
        </xsl:for-each>
        
        <xsl:for-each select="$editor">
            <meta name="dcterms.creator">
                <xsl:attribute name="content">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </meta>
        </xsl:for-each>
        
        <!-- OPEN GRAPH (following OG Protocol: http://ogp.me/ -->
        <meta property="og:type" content="{$type}"></meta>
        <meta property="og:url" content="{$url}" />
        <meta property="og:image" content="{$image}" />
        <meta property="og:description" content="{$description}" />
        <meta property="og:title" content="{$title}" />
        <meta property="og:description" content="{$description}"></meta>
        
        <xsl:for-each select="$author">
            <meta property="og:book:author">
                <xsl:attribute name="content">
                    <xsl:value-of select="."/>
                </xsl:attribute>
                
            </meta>
        </xsl:for-each>
        
        <xsl:for-each select="$editor">
            <meta property="og:book:author">
                <xsl:attribute name="content">
                    <xsl:value-of select="."/>
                </xsl:attribute>
                
            </meta>
        </xsl:for-each>
        
        
    </xsl:template>
    
    <!-- 
    
    
    
    
    
    
     -->
    
    
    
    
</xsl:stylesheet>