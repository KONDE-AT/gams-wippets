<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org"
    xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">

    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>

    <!-- 
    Namenskonvention:
    {funktionalität/widget-name}.{Untertypen}*.{container-html-element}.xsl
    -->
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Simple Open Seadragon Viewer Wippet</h1>
            <p>gerlinde.schneider@uni-graz.at; christian.steiner@uni-graz.at</p>
            <p>Auf Ebene html:div anzuwenden.</p>
            <p>... und hier bitte alles erklären ...</p>
            <p>Beispiel: <a href="http://gams.uni-graz.at/o:gm.1"
                >http://gams.uni-graz.at/o:gm.1</a></p>
            <p>
                <b>Abhängigkeiten:</b>
                <p>Dieses Script im Header einbauen: &lt;script type="text/javascript"
                    src="/osdviewer/openseadragon.js"&gt;//&lt;/script&gt;
                    <!--<script type="text/javascript" src="/osdviewer/openseadragon.js">//</script>--></p>
            </p>
        </desc>
        <param name="pid"><b>PID</b>: PID des Objekts angeben</param>
        <param name="showIiifLabels"><b/>: angeben ob die Labels aus dem IIIF angezeigt werden
            sollen. Wenn ja den Wert auf `true` setzen!</param>
        <return>&lt;div id="vwr-content"&gt;</return>
    </doc>


    <xsl:template name="simple_osd_viewer">
        <xsl:param name="pid"/>
        <xsl:param name="showIiifLabels">false</xsl:param>
        <div id="vwr-content">
            <xsl:text> </xsl:text>
        </div>
        <script type="text/javascript" src="/osdviewer/gamsOsd.js"><xsl:text> </xsl:text></script>
        <script type="text/javascript">
                gamsOsd({
                id: "vwr-content",
                prefixUrl: "/osdviewer/images/",
                showNavigator: true,
                sequenceMode: true,
                showReferenceStrip: true,
                showRotationControl: true,
                showIiifLabels: <xsl:value-of select="$showIiifLabels"/>,
                referenceStripScroll: "horizontal",
                pid:"<xsl:value-of select="$pid"/>"
                });
            </script>
    </xsl:template>

    <!-- Im eigenen XSLT bitte so das template an der Stelle wo man den Viewer haben will callen-->
    <!--<xsl:call-template name="simple_osd_viewer">
            <xsl:with-param name="pid"/>
        </xsl:call-template>-->

</xsl:stylesheet>
