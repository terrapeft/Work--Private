<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <xsl:for-each select="pp/p">
      <xsl:variable name="altColor">
        <xsl:choose>
          <xsl:when test="position() mod 2 = 0">#EEEEEE</xsl:when>
        </xsl:choose>
      </xsl:variable>
      <div style="width:100%; /*background-color: {$altColor}*/">
        <b>
          <xsl:call-template name="name">
            <xsl:with-param name="nm" select="n" />
          </xsl:call-template>:&#160;
        </b>
        <xsl:call-template name="value">
          <xsl:with-param name="sn" select="v" />
        </xsl:call-template>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="name">
    <xsl:param name="nm"></xsl:param>

    <xsl:choose>
      <xsl:when test="$nm = 's'">
        Keyword
      </xsl:when>
      <xsl:when test="$nm = 'se'">
        Extended search
      </xsl:when>
      <xsl:when test="$nm = 'sc'">
        Search group ids
      </xsl:when>
      <xsl:when test="$nm = 'pg'">
        Page
      </xsl:when>
      <xsl:when test="$nm = 'ps'">
        Page size
      </xsl:when>
      <xsl:when test="$nm = 'u'">
        Username
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$nm"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="value">
    <xsl:param name="sn"></xsl:param>
    <span class="auditValue">
      <xsl:value-of select="$sn"/>
    </span>
  </xsl:template>

</xsl:stylesheet>