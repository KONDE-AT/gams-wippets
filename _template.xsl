<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <!-- 
    Namenskonvention:
    {funktionalität/widget-name}.{Untertypen}*.{container-html-element}.xsl
    -->
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget XYZ</h1>
            <p>Autor-Email</p>
            <p>Auf Ebene html:... (article|div ...) anzuwenden.</p>
            <p>... und hier bitte alles erklären ...</p>
            <p>Beispiel: <a href="#">Beispiel-Link</a></p>
            <p>Abhängigkeiten: welche js, css etc. Dateien müssen wo eingebunden werden</p>
        </desc>
        <depends>
            
        </depends>
        <param><b>abc</b>: der Parameter tut auch etwas ... </param>
        <return>Rückgabewert des Templates, z.B. Element div</return>
    </doc>
    
    <xsl:param name="abc"/>
    
    <xsl:template name="xyz">
        <!-- ...  -->
    </xsl:template>
</xsl:stylesheet>