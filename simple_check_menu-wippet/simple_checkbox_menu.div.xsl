<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org" xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
    
    <xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget simple_checkbox_menu</h1>
            <p>roman.bleier@uni-graz.at</p>
            <p>Auf Ebene html:div anzuwenden.</p>
            <p>Die Template "simple_checkbox_menu" enthält die einzelnen Checkboxen und muss projekspezifisch angepasst werden.</p>
            <p>Die "input" Elemente der Checkboxen müssen eine Class "scm-checkbox" haben und die Attribute "data-scm-target" (Wert: ein JQuery Selector) und "data-scm-class" (Wert: eine CSS classe)</p>
            <p>Es muss auch ein JQuery Plugin in die Seite eingebunden werden (simple_checkbox_menu.div.div.js).</p>
            <p>CSS Classes müssen auch projektspezifisch angepasst werden. Einige sind vordefiniert und können über das folgende File eingebunden werden: simple_checkbox_menu.div.css.</p>
            <p>Beispiel: <a href="http://glossa.uni-graz.at/o:epistles.1400"
                >http://glossa.uni-graz.at/o:epistles.1400</a></p>
            <p>
                <b>Abhängigkeiten:</b>
                <p>Dieses Script im Header einbauen: &lt;script type="text/javascript"
                    src="/simple_checkbox_menu.div.js"&gt;//&lt;/script&gt;
                    und eine Referenz zur CSS Datei: 
                    &lt;link href="/simple_checkbox_menu.div.css" rel="stylesheet" type="text/css"/&gt;
                    </p>
            </p>
            
        </desc>
        
    </doc>
    
    
    <xsl:template name="simple_checkbox_menu">
        <!-- 'checkbox' class on ul is a bootstrp class -->
        <ul class="checkbox">
            
            <!-- Beispiel für eine Checkbox, die die Elemente mit der Klasse 'linenumber' versteckt und wieder sichtbar macht -->
            <li>
                <input class="scm-checkbox" type="checkbox" data-scm-target=".linenumber" data-scm-class="scm-element-hide">
                    
                </input>
                <label><xsl:text>Hide the line number of the manuscript</xsl:text></label>
            </li>
            
            <!-- Beispiel für eine Checkbox, die den Text in den Elementen mit der Klasse 'ex' hervorhebt (z.B. durch eine entsprechende Font-Color) -->
            <li>
                <input class="scm-checkbox" type="checkbox" data-scm-target=".ex" data-scm-class="scm-font-highlight">
                    
                </input>
                <label>
                    <xsl:text>Highlight abbreviations</xsl:text>
                </label>
            </li>
            <!-- Beispiel für eine Checkbox, die die Elemente mit der Klasse 'pc' mit einer bestimmten Background-Color hervorhebt -->
            <li>
                <input class="scm-checkbox" type="checkbox" data-scm-target=".pc" data-scm-class="scm-bg-highlight">
                    
                </input>
                <label>
                    <xsl:text>Highlight punctuation</xsl:text>
                </label>
            </li>
        </ul>
        
    </xsl:template>
    
    
    
</xsl:stylesheet>