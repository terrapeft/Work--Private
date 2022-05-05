<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:param name="showColumnNames"/>
	<xsl:param name="alternativeItemColor"/>
	<xsl:template match="NewDataSet">
		<table class="xslt-table" cellpadding="0" cellspacing="0">

			<!-- column names -->
			<xsl:choose>
				<xsl:when test="$showColumnNames = 'True'">
					<xsl:apply-templates select="Table[1]"/>
				</xsl:when>
			</xsl:choose>

			<!-- values -->
			<xsl:for-each select="*">
				<xsl:variable name="altColor">
					<xsl:choose>
						<xsl:when test="position() mod 2 = 0">
							<xsl:choose>
								<xsl:when test="$alternativeItemColor = ''">white</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$alternativeItemColor"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<tr style="background-color: {$altColor}">
					<xsl:call-template name="Nemo">
						<xsl:with-param name="sn" select="." />
					</xsl:call-template>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>

	<xsl:template match="Table">
		<tr class="xslt-table-header">
			<xsl:for-each select="*">
				<td style="padding-right: 4px; padding-left:4px;">
					<b>
						<xsl:value-of select="name()"/>
					</b>
				</td>
			</xsl:for-each>
		</tr>
	</xsl:template>

	<xsl:template name="Nemo">
		<xsl:param name="sn"/>
		<xsl:for-each select="$sn/*">
			<td style="padding-right: 4px; padding-left:4px;">
				<xsl:value-of select="."/>
			</td>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
