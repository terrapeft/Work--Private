<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:key name="pfkey" match="ProductFamily" use="PFCode"/>
  <xsl:template match="marginRatesFile">
    <root>
      <dictionaries>
        <xsl:for-each select="//ProductFamily">
          <xsl:if test="generate-id() = generate-id(key('pfkey', PFCode))">
            <xsl:copy>
              <xsl:copy-of select="@*"/>
              <Id>
                <xsl:value-of select="generate-id()"/>
              </Id>
              <xsl:copy-of select="*"/>
            </xsl:copy>
            <xsl:text/>
          </xsl:if>
        </xsl:for-each>
      </dictionaries>
      <marginRatesFile>
        <xsl:apply-templates/>
      </marginRatesFile>
    </root>
  </xsl:template>
  <!-- string to bit -->
  <xsl:template match="isPercentage">
    <xsl:copy>
      <xsl:call-template name="StringToBit">
        <xsl:with-param name="strValue" select="text()"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="isPctM">
    <xsl:copy>
      <xsl:call-template name="StringToBit">
        <xsl:with-param name="strValue" select="text()"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="isPctV">
    <xsl:copy>
      <xsl:call-template name="StringToBit">
        <xsl:with-param name="strValue" select="text()"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="isPctS">
    <xsl:copy>
      <xsl:call-template name="StringToBit">
        <xsl:with-param name="strValue" select="text()"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <xsl:template name="StringToBit">
    <xsl:param name="strValue"/>
    <xsl:choose>
      <xsl:when test="$strValue = 'True' or $strValue = 'true'">
        <xsl:text>1</xsl:text>
      </xsl:when>
      <xsl:when test="$strValue = 'False' or $strValue = 'false'">
        <xsl:text>0</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="BFCC">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
    </xsl:copy>
  </xsl:template>
  <!-- this template puts the id tag with generated id instead of content -->
  <xsl:template match="ProductFamily" mode="subs">
    <Id>
      <xsl:value-of select="generate-id(key('pfkey', PFCode))"/>
    </Id>
  </xsl:template>
  <!-- this empty template prevents from copying the content of the extracted node when the <xsl:apply-templates/> is called -->
  <xsl:template match="ProductFamily"/>
  <!-- this will set the flag for all current products -->
  <xsl:template match="OutrightRates/Current/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>1</IsCurrent>
      <Outright>1</Outright>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="IntraCommodityRates/Current/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>1</IsCurrent>
      <IntraCommodity>1</IntraCommodity>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="InterCommodityRates/Current/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>1</IsCurrent>
      <InterCommodity>1</InterCommodity>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="IntexRates/Current/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>1</IsCurrent>
      <Intex>1</Intex>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <!-- this will set the flag for all future products -->
  <xsl:template match="OutrightRates/Future/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>0</IsCurrent>
      <Outright>1</Outright>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="IntraCommodityRates/Future/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>0</IsCurrent>
      <IntraCommodity>1</IntraCommodity>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="InterCommodityRates/Future/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>0</IsCurrent>
      <InterCommodity>1</InterCommodity>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="IntexRates/Future/Product">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>0</IsCurrent>
      <Intex>1</Intex>
      <xsl:if test="ProductFamily">
        <PFIds>
          <xsl:apply-templates select="ProductFamily" mode="subs"/>
        </PFIds>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <!-- this will set the flag for all current tier products -->
  <xsl:template match="CurrentTier/TierProduct">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>1</IsCurrent>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <!-- this will set the flag for all future tier products -->
  <xsl:template match="FutureTier/TierProduct">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <IsCurrent>0</IsCurrent>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- this will add to output all other nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
