<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<xsl:for-each select="r/*">
			<xsl:variable name="altColor">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">#EEEEEE</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<div style="width: 100%; /*background-color: {$altColor}*/">
				<b style="white-space: nowrap">
					<xsl:call-template name="mapName">
						<xsl:with-param name="sn" select="name()" />
					</xsl:call-template>
				</b>
				<xsl:value-of select="."/>
			</div>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="mapName">
		<xsl:param name="sn"></xsl:param>
		<xsl:choose>
			<xsl:when test="$sn = 'ip'">IP: </xsl:when>
			<xsl:when test="$sn = 'cc'">Country code: </xsl:when>
			<xsl:when test="$sn = 'cn'">Country name: </xsl:when>
			<xsl:when test="$sn = 'rc'">Region code: </xsl:when>
			<xsl:when test="$sn = 'rn'">Region name: </xsl:when>
			<xsl:when test="$sn = 'c'">City: </xsl:when>
			<xsl:when test="$sn = 'z'">Zip code: </xsl:when>
			<xsl:when test="$sn = 'm'">Metro code: </xsl:when>
			<xsl:when test="$sn = 'a'">Area code: </xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>