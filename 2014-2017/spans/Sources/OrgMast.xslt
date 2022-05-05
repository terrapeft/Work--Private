<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes" method="xml"/>
	<xsl:key name="r-key" match="r" use="."/>
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="spanOrgMastFile">
		<root>
			<dictionaries>
				<DeltaPoint>
					<xsl:for-each select="//DeltaPoint/r">
						<xsl:apply-templates select="." mode="dictionary"/>
					</xsl:for-each>
				</DeltaPoint>
				<ScanPoint>
					<xsl:for-each select="//ScanPoint/r">
						<xsl:apply-templates select="." mode="dictionary"/>
					</xsl:for-each>
				</ScanPoint>
				<Rounding>
					<xsl:for-each select="//Rounding/r">
						<xsl:apply-templates select="." mode="dictionary"/>
					</xsl:for-each>
				</Rounding>
			</dictionaries>
			<xsl:copy>
				<xsl:apply-templates/>
			</xsl:copy>
		</root>
	</xsl:template>
	
	<!-- this template copies <r> node completely and adds the id -->
	<xsl:template match="r" mode="dictionary">
		<xsl:if test="generate-id() = generate-id(key('r-key', normalize-space(.)))">
			<xsl:copy>
				<xsl:copy-of select="@*"/>
				<Id>
					<xsl:value-of select="generate-id()"/>
				</Id>
				<xsl:copy-of select="*"/>
			</xsl:copy>
			<xsl:text/>
		</xsl:if>
	</xsl:template>

	<!-- this set of <r> templates puts the id tag with generated id instead of content -->
	<xsl:template match="Rounding/r">
		<id><xsl:value-of select="generate-id(key('r-key', normalize-space(.)))"/></id>
	</xsl:template>
	<xsl:template match="DeltaPoint/r">
		<id><xsl:value-of select="generate-id(key('r-key', normalize-space(.)))"/></id>
	</xsl:template>
	<xsl:template match="ScanPoint/r">
		<id><xsl:value-of select="generate-id(key('r-key', normalize-space(.)))"/></id>
	</xsl:template>
	
	<xsl:template match="text()">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- this will add to output all other nodes except empty ones -->
	<!--	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()[boolean(normalize-space())]|@*"/>
		</xsl:copy>
	</xsl:template>-->
	
	<!-- this will add to output all other nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
