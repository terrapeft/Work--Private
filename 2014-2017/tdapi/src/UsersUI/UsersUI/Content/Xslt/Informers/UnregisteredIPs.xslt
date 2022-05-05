<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:param name="showColumnNames"/>
	<xsl:param name="alternativeItemColor"/>
	<xsl:template match="NewDataSet">
		<table class="xslt-table" cellpadding="0" cellspacing="0">

			<!-- column names -->
			<tr class="xslt-table-header">
				<td class="pad">User</td>
				<td class="pad">IP</td>
				<!--<td class="pad"></td>-->
			</tr>

			<!-- values -->
			<xsl:for-each select="Table">
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
				</xsl:variable>				<tr style="background-color: {$altColor}">
					<td align="left">
						<xsl:choose>
							<xsl:when test="UserId != ''">
								<a href="Users/Details.aspx?Id={UserId}">
									<xsl:value-of select="Fullname"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="Username"/>
							</xsl:otherwise>
						</xsl:choose>&#160;
					</td>
					<td>
						<xsl:value-of select="IP"/>&#160;
					</td>
<!--
					<td align="left">
						<xsl:variable name="hrefVal">
							IPs/Insert.aspx?ip=<xsl:value-of select="IP" />
							<xsl:choose>
								<xsl:when test="CompanyId != ''">
									&amp;companyId=<xsl:value-of select="CompanyId" />
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<a href="AllowedIPs/Insert.aspx?ip={IP}&amp;companyId={CompanyId}" target="_blank">
							<xsl:attribute name="href">
								<xsl:value-of select="$hrefVal" />
							</xsl:attribute>
							Register
						</a>
					</td>
-->
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>
