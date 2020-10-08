<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:p1="Deal_x0020_Detail" exclude-result-prefixes="p1">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <deal>
            <xsl:for-each select="//p1:Detail">
                <xsl:variable name="rN" select="normalize-space(@RetailerName)" />
                <xsl:if test="$rN='D-090 Jay C' or $rN='D-706 Smiths' or $rN='D-660 Frys' or $rN='D-620 King Soopers' or $rN='D-615 Dillon' or $rN='D-704 Food for Less - West' or $rN='D-705 QFC Seattle' or $rN='D-703 Ralphs' or $rN='D-701 Fred Meyer' or $rN='D-708 Food for Less Chicago' or $rN='D-035 Dallas' or $rN='D-034 Houston' or $rN='D-024 Louisville' or $rN='D-021 Central' or $rN='D-011 Atlanta' or $rN='D-025 Delta' or $rN='D-026 Nashville' or $rN='D-018 Michigan' or $rN='D-029 MidAtlantic' or $rN='D-014 Cincinnati' or $rN='D-016 Columbus' or $rN='D-531 Roundys Chicago' or $rN='D-534 Roundys Wisconsin'">
                    <detail>
                        <xsl:attribute name="customerreferencenumber">
                            <xsl:value-of select='@offernumber'/>
                        </xsl:attribute>
                        <xsl:attribute name="requestby">
                            <xsl:value-of select='@repname'/>
                        </xsl:attribute>
                        <xsl:attribute name="description">
                            <xsl:value-of select='@DealDescription'/>
                        </xsl:attribute>
                        <xsl:attribute name="pricetype">
                            <xsl:value-of select='@textbox44'/>
                        </xsl:attribute>
                        <xsl:attribute name="performancetype">
                            <xsl:value-of select='@PriceTypeName'/>
                        </xsl:attribute>
                        <xsl:variable name="sd">
                            <xsl:call-template name="cvD">
                                <xsl:with-param name="dS" select="@performancestartdate"/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:attribute name="startdate">
                            <xsl:value-of select="$sd"/>
                        </xsl:attribute>
                        <xsl:variable name="ed">
                            <xsl:call-template name="cvD">
                                <xsl:with-param name="dS" select="@performanceenddate"/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:attribute name="enddate">
                            <xsl:value-of select="$ed"/>
                        </xsl:attribute>
                        <xsl:attribute name="retailname">
                            <xsl:value-of select='normalize-space(@RetailerName)'/>
                        </xsl:attribute>
                        <xsl:attribute name="itemdescription">
                            <xsl:value-of select='@itemdescription'/>
                        </xsl:attribute>
                        <xsl:attribute name="upccode">
                            <xsl:value-of select='@UPCConsumer'/>
                        </xsl:attribute>
                        <xsl:attribute name="primaryunitallowance">
                            <xsl:value-of select='@PrimaryUnitAllowAmt'/>
                        </xsl:attribute>
                        <xsl:attribute name="currentcost">
                            <xsl:value-of select='@UnitCost'/>
                        </xsl:attribute>
                        <xsl:attribute name="retailprice">
                            <xsl:value-of select='@PromoPrice'/>
                        </xsl:attribute>
                        <xsl:attribute name="pricevalue1">
                            <xsl:value-of select='@PriceValue1'/>
                        </xsl:attribute>
                        <xsl:attribute name="vendorname">
                            <xsl:value-of select='@vendorname'/>
                        </xsl:attribute>
                    </detail>
                </xsl:if>
            </xsl:for-each>
        </deal>
    </xsl:template>
    <xsl:template name="cvD">
        <xsl:param name="dS"/>
        <xsl:choose>
            <xsl:when test="contains($dS, '/')">
                <xsl:variable name="cDS">
                    <xsl:call-template name="cvtD">
                        <xsl:with-param name="wStr" select="$dS"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:value-of select="$cDS"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$dS"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="cvtD">
        <xsl:param name="wStr"/>
        <xsl:variable name="mm">
            <xsl:value-of select="substring-before($wStr,'/')" />
        </xsl:variable>
        <xsl:variable name="amm">
            <xsl:value-of select="substring-after($wStr,'/')" />
        </xsl:variable>
        <xsl:variable name="dd">
            <xsl:value-of select="substring-before($amm,'/')" />
        </xsl:variable>
        <xsl:variable name="yy">
            <xsl:value-of select="substring-after($amm,'/')" />
        </xsl:variable>
        <xsl:variable name="pmm">
            <xsl:call-template name="pZ">
                <xsl:with-param name="str" select="$mm"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="pdd">
            <xsl:call-template name="pZ">
                <xsl:with-param name="str" select="$dd"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($yy,'-',$pmm, '-', $pdd,'T')" />
    </xsl:template>
    <xsl:template name="pZ">
        <xsl:param name="str"/>
        <xsl:choose>
            <xsl:when test="string-length($str) = 1">
                <xsl:value-of select="concat('0',$str)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$str"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>