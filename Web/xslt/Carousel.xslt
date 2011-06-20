<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY nbsp "&#x00A0;">
]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library"
exclude-result-prefixes="msxml umbraco.library">

    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:param name="currentPage"/>
    <xsl:variable name="macro" select="macro"/>

    <xsl:template match="/">
        <xsl:value-of select="umbraco.library:RegisterStyleSheetFile('tango', '/css/carousel/skins/tango/skin.css')"/>
        <xsl:value-of select="umbraco.library:RegisterStyleSheetFile('carouselcss', '/css/carousel/styles.css')"/>
        <xsl:value-of select="umbraco.library:AddJquery()"/>
        <xsl:value-of select="umbraco.library:RegisterJavaScriptFile('jcarousel', '/scripts/jquery.jcarousel.min.js')"/>
        <xsl:value-of select="umbraco.library:RegisterJavaScriptFile('carouseljs', '/scripts/carousel.settings.js')"/>
        <xsl:apply-templates select="macro"/>
    </xsl:template>

    <xsl:template match="macro">
        <xsl:choose>
            <xsl:when test="carouselName != ''">
                <xsl:apply-templates select="$currentPage/Carousel[name() = carouselName]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$currentPage/Carousel" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="Carousel">
        <div>
            <style>
                <xsl:if test="backgroundImage != ''">
                    .jcarousel-skin-tango { 
                        background: url(<xsl:value-of select="umbraco.library:GetMedia(backgroundImage, true)/umbracoFile"/>) no-repeat scroll 0 0 transparent;
                    }
                </xsl:if>

                .jcarousel-skin-tango .jcarousel-container-horizontal {
                    padding: 0;
                    height: <xsl:value-of select="$macro/height" />px;
                    width: <xsl:value-of select="$macro/width"/>px;
                }

                .jcarousel-skin-tango .jcarousel-container {
                    -moz-border-radius: 0;
                    background: none;
                    border: 0;
                }

                .jcarousel-skin-tango .jcarousel-clip-horizontal {
                    width: <xsl:value-of select="$macro/width"/>px;
                    height: <xsl:value-of select="$macro/height"/>px;
                }

                .jcarousel-skin-tango .jcarousel-item {
                height: <xsl:value-of select="$macro/height"/>px;
                    width: <xsl:value-of select="$macro/width"/>px;
                }

                .jcarousel-skin-tango .jcarousel-item-horizontal {
                    margin-left: 0;
                    margin-right: 0;
                }

                .jcarousel-skin-tango .jcarousel-next-horizontal, .jcarousel-skin-tango .jcarousel-prev-horizontal {
                    top: <xsl:value-of select="$macro/height div 2 - 22"/>px;
                }
            </style>
        </div>

        <div id="{@nodeName}" class="carousel jcarousel-skin-tango">
            <ul>
                <xsl:for-each select="Slide">
                    <li>
                        <xsl:apply-templates select="."/>
                    </li>
                </xsl:for-each>
            </ul>
            <ul class="carousel-paging">
                <xsl:for-each select="$currentPage/Carousel/Slide">
                    <li>
                        <div class="carousel-paging-item"> </div>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
        <script>
            $('#<xsl:value-of select="@nodeName"/>').data("settings", {
                height: "<xsl:value-of select="$macro/height"/>px",
                width: "<xsl:value-of select="$macro/width"/>px",
                auto: 1,
                wrap: 'circular',
                scroll: 1
            });
        </script>
    </xsl:template>

    <xsl:template match="Slide">
        <xsl:value-of select="bodyText" disable-output-escaping="yes"/>
    </xsl:template>

</xsl:stylesheet>