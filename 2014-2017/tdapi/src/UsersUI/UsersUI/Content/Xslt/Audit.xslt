<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<xsl:for-each select="values/*">
			<xsl:variable name="altColor">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">#EEEEEE</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<div style="width: 100%; /*background-color: {$altColor}*/">
				<b>
					<xsl:value-of select="name()"/>:
				</b>
				<xsl:choose>
					<xsl:when test="o and n">
						<span style="color: red">
							<xsl:call-template name="value">
								<xsl:with-param name="sn" select="o" />
							</xsl:call-template>
						</span>&#160;➝&#160;
						<xsl:call-template name="value">
							<xsl:with-param name="sn" select="n" />
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="o and not(n)">
						<xsl:value-of select="o"/>
					</xsl:when>
					<xsl:when test="not(o) and n">
						<xsl:call-template name="value">
							<xsl:with-param name="sn" select="n" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</div>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="value">
		<xsl:param name="sn"></xsl:param>
		<span class="auditValue">
			<xsl:value-of select="$sn"/>
		</span>
	</xsl:template>
</xsl:stylesheet>