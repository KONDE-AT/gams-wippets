<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget Sidebar</h1>
            <p>christian.steiner@uni-graz.at</p>
            <p>Auf Ebene html:article anzuwenden.</p>
            <p>Die Template "sidebar_content" enthält die einzelnen Listenpunkte. Muss projekspezifisch eingefügt werden.</p>
        </desc>
        <param><b>column-width</b>: Bootstrap Breitenangabe z.B. col-md-4</param>
    </doc>


    <xsl:template name="sidebar">
        <!--Param column-width: Bootstrap Breitenangabe des <article>-->
        <xsl:param name="column-width"/>
        
        <!-- ANFANG JS: Der folgende script code sollte in den Head-Bereich oder direkt nach dem Footer des HTML kopiert werden -->
        <script src="//gams.uni-graz.at/lib/1.0/plugins/stickyfloat/stickyfloat.js">//</script>
        <script>
            $(document).ready(function () {
            $('article#sidebar').stickyfloat({
            duration: 0, startOffset: 70
            });});
        </script>
        <!-- ENDE JS -->
        
        <article class="{$column-width}" id="sidebar">
            <div class="panel" style="overflow: auto; max-height: 75vh;">
<!--                <xsl:call-template name="sidebar_content"/>-->
            </div>
        </article>
    </xsl:template>
    
    <!-- Links in Sidebar müssen projektspezifisch angepasst werden -->
        <!--z.B. 
    <xsl:template name="sidebar_content">
            <div>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#anchor1</xsl:text>
                </xsl:attribute>
                Link1
            </a>
        </div>
        
        <div>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#anchor2</xsl:text>
                </xsl:attribute>
                Link2
            </a>
        </div>
    </xsl:template> 
        -->
</xsl:stylesheet>