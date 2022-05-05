<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:param name="showColumnNames"/>
	<xsl:param name="alternativeItemColor"/>
	<xsl:template match="NewDataSet">
		<table class="xslt-table" cellpadding="0" cellspacing="0">

			<!-- column names -->
			<tr class="xslt-table-header">
				<td class="pad">User</td>
				<td class="pad">Status</td>
				<td class="pad">Method</td>
				<td class="pad">Date</td>
				<td class="pad">Format</td>
				<td class="pad">Dur. (sec)</td>
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
				</xsl:variable>
				<tr class="xslt-values" style="background-color: {$altColor}">
					<td class="">
						<a href="Users/Details.aspx?Id={UserId}">
							<xsl:value-of select="CompanyName"/>/<xsl:value-of select="FullName"/>
						</a>
					</td>
					<td>
            <span>
              <xsl:attribute name="title">
                <xsl:value-of select="HttpStatusCode"/>
              </xsl:attribute>
              <xsl:value-of select="StatusName"/>
            </span>
					</td>
					<td>
            <a href="UsageStats/Details.aspx?Id={rid}">
              <xsl:value-of select="Method"/>
            </a>
					</td>
					<td>
						<xsl:value-of select="concat(
                      substring(RequestDate, 9, 2),
                      '/',
                      substring(RequestDate, 6, 2),
                      '/',
                      substring(RequestDate, 1, 4),
							' ',
							substring(RequestDate, 12, 2),
									  
							':',
							substring(RequestDate, 15, 2)
                      )"/>
					</td>
					<td>
						<xsl:value-of select="RequestType"/>
					</td>
					<td>
						<xsl:value-of select='format-number(Duration div 1000, "#,#0,.00")' />
					</td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>
