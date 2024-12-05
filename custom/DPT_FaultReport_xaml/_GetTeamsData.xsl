<xsl:stylesheet 
xmlns:dls="http://www.datolitesolutions.com/functions" 
xmlns:saxon="http://saxon.sf.net/"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
	<xsl:output name="htmlanswer" encoding="utf-8" method="xhtml" indent="no" omit-xml-declaration="yes"/>
	
	<xsl:template name="GetTeamsData" match="/">
		<!--  new comment test -->
		
		<!--Generate list of templates that have faulted-->
		<xsl:variable name="fulllist">
			<DLSTeamsData>
				<!--<filteredblock><xsl:copy-of select="/DLSFaultLog/theEvents[Events/LogEntry]"/></filteredblock>-->
				<TemplateList>
					<xsl:for-each select="/DLSFaultLog/theEvents[Events/LogEntry]">
						<xsl:sort select="Events/LogEntry[1]/Event/System/TimeCreated/@SystemTime" order="descending"/>
						<Template>
							<TemplateName>
								<xsl:variable name="tokens" select="tokenize(Events/Attributes/TemplateName, '-')"/>
								<xsl:value-of select="string-join(subsequence($tokens, 1, count($tokens) - 1), '-')"/>
							</TemplateName>
							<!--<xsl:if test="position() = 1">-->
							<InstanceID>
								<xsl:value-of select="Events/Attributes/InstanceID"/>
							</InstanceID>
							<Timestamp>
								<xsl:variable name="insID" select="Events/Attributes/InstanceID"/>
								<xsl:value-of select="Events/LogEntry[1]/Event/System/TimeCreated[1]/@SystemTime"/>
							</Timestamp>
							<!--</xsl:if>-->
							<Faults>
								<xsl:variable name="insID" select="Events/Attributes/InstanceID"/>
								<xsl:for-each select="Events[Attributes/InstanceID = $insID]/LogEntry/Event/EventData/Data[@Name = 'message']">
									<xsl:if test="position() = 2">
										<Fault>
											<xsl:value-of select="concat(dls:trimdown(.),'...')"/>
										</Fault>
									</xsl:if>
								</xsl:for-each>
							</Faults>
						</Template>
					</xsl:for-each>
				</TemplateList>
			</DLSTeamsData>
		</xsl:variable>
		
		<DLSRoot>
			<TemplateList>
				<!--Merge list of all templates that have faulted, that contain logs-->
				<xsl:variable name="joined" select="normalize-space(string-join(distinct-values($fulllist/DLSTeamsData/TemplateList/Template/TemplateName), ';'))"/>
				<Attributes>
					<Joined>
						<xsl:variable name="jtmp">
							<xsl:analyze-string select="$joined" regex="([^;]+)(;)?">
								<xsl:matching-substring>
									<xsl:value-of select="concat('**', regex-group(1), '**\n')"/>
									<xsl:if test="regex-group(2)">
										<xsl:text>; </xsl:text>
									</xsl:if>
								</xsl:matching-substring>
								<xsl:non-matching-substring>
									<xsl:value-of select="."/>
								</xsl:non-matching-substring>
							</xsl:analyze-string>
						</xsl:variable>
						<xsl:value-of select="replace(replace($jtmp, ' ', ''),';','')"/>
					</Joined>
				</Attributes>
				
		
				<xsl:variable name="jsonHolder">
					<JSon>
						<xsl:for-each select="$fulllist/DLSTeamsData/TemplateList/Template">
							<line>
<!--								<xsl:value-of select="concat('{&quot;type&quot;:&quot;ColumnSet&quot;,&quot;columns&quot;:[{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;auto&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;Template Name: &quot;,&quot;weight&quot;:&quot;Bolder&quot;}]},{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;stretch&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;**', TemplateName, '**&quot;,&quot;wrap&quot;:&quot;true&quot;}]}]},{&quot;type&quot;:&quot;ColumnSet&quot;,&quot;columns&quot;:[{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;auto&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;Fault Snippet: &quot;,&quot;weight&quot;:&quot;Bolder&quot;}]},{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;stretch&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;', concat('*',Faults/Fault,'*'), '&quot;,&quot;wrap&quot;:&quot;true&quot;}]}', if (position() != last()) then ']},' else ']}')"/>-->
								<xsl:value-of select="concat('{&quot;type&quot;:&quot;ColumnSet&quot;,&quot;columns&quot;:[{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;auto&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;Template Name: &quot;,&quot;weight&quot;:&quot;Bolder&quot;}]},{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;stretch&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;**', TemplateName, '**&quot;,&quot;wrap&quot;:&quot;true&quot;}]}]},{&quot;type&quot;:&quot;ColumnSet&quot;,&quot;columns&quot;:[{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;auto&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;Timestamp: &quot;,&quot;weight&quot;:&quot;Bolder&quot;}]},{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;stretch&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;**', Timestamp, '**&quot;,&quot;wrap&quot;:&quot;true&quot;}]}]},{&quot;type&quot;:&quot;ColumnSet&quot;,&quot;columns&quot;:[{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;auto&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;Fault Snippet: &quot;,&quot;weight&quot;:&quot;Bolder&quot;}]},{&quot;type&quot;:&quot;Column&quot;,&quot;width&quot;:&quot;stretch&quot;,&quot;items&quot;:[{&quot;type&quot;:&quot;TextBlock&quot;,&quot;text&quot;:&quot;', concat('*',Faults/Fault,'*'), '&quot;,&quot;wrap&quot;:&quot;true&quot;}]}', if (position() != last()) then ']},' else ']}')"/>
							</line>
						</xsl:for-each>
					</JSon>
				</xsl:variable>
				<JsonData>
					<xsl:value-of select="normalize-space(string-join($jsonHolder/JSon/line, ' '))"/>
				</JsonData>
			</TemplateList>
		</DLSRoot>
		
	</xsl:template>
	<xsl:function name="dls:trimdown">
		<xsl:param name="inputString"/>
		<xsl:sequence select="substring($inputString, 1, 200)"/>
	</xsl:function>
</xsl:stylesheet>