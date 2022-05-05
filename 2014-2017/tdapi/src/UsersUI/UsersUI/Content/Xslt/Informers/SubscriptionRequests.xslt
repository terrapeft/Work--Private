<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:param name="showColumnNames"/>
	<xsl:param name="alternativeItemColor"/>
	<xsl:template match="NewDataSet">
		<table class="xslt-table" cellpadding="0" cellspacing="0">

			<!-- column names -->
			<tr class="xslt-table-header">
				<td class="pad">Request Id</td>
				<td class="pad">Request date</td>
				<td class="pad">User</td>
        <td class="pad">Type</td>
        <td/>
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
				<tr style="background-color: {$altColor}">
					<td>
						<a href="SubscriptionRequests/Edit.aspx?Id={RequestId}">
							Req #<xsl:value-of select="RequestId"/>
						</a>

					</td>
					<td>
						<xsl:value-of select="concat(
                      substring(LastUpdate, 9, 2),
                      '/',
                      substring(LastUpdate, 6, 2),
                      '/',
                      substring(LastUpdate, 1, 4))"/>
					</td>
					<td align="left">
						<a href="Users/Details.aspx?Id={UserId}">
							<xsl:value-of select="FullName"/>
						</a>
					</td>
          <td align="left">
              <xsl:value-of select="RequestType"/>
          </td>
        </tr>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>
