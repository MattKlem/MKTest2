<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:tlr="http://www.elite.com/functions" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:saxon="http://saxon.sf.net/"
version="3.0">
	
	<xsl:output name="htmlanswer" encoding="utf-8" method="xhtml" indent="no" omit-xml-declaration="yes"/>
	
	<xsl:template name="ReportBody">
	
		<xsl:for-each-group select="/DLSFaultLog/theEvents[Events/LogEntry]" group-by="Events/Attributes/InstanceID">
			<xsl:sort select="Events/Attributes/Timestamp" order="descending"/>
			
			<xsl:variable name="insID" select="Events/Attributes/InstanceID"/>
			
			<!-- Tokenize the input string by dashes -->
    <xsl:variable name="tokens" select="tokenize(Events/Attributes/TemplateName, '-')"/>
    
    <!-- Remove the last token and join the remaining tokens with dashes -->
    <!--<xsl:value-of select="string-join(subsequence($tokens, 1, count($tokens) - 1), '-')" />-->
			
		<xsl:variable name="tName" select="concat(string-join(subsequence($tokens, 1, count($tokens) - 1), '-'),'-',position())"/>
		
		<!-- comment -->
		<Worksheet ss:Name="{$tName}">
			<xsl:variable name="RC" select="count(/DocumentElement/Results/Id)"/>
			<xsl:variable name="theRange" select="concat('=All!R1C1:R', $RC, 'C10')"/>
			<!--<Names>
				<NamedRange ss:Name="_FilterDatabase" ss:RefersTo="{$theRange}" ss:Hidden="1"/>
			</Names>-->
			<Table>
				<Column ss:Width="75"/>
				<Column ss:Width="100"/>
				<Column ss:Width="150"/>
				<Column ss:Width="75"/>
				<Column ss:Width="100"/>
				<Column ss:Width="300"/>
				<Column ss:Width="300"/>
				
				<Row ss:StyleID="s71">
					<Cell>
						<Data ss:Type="String">Type</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Timestamp</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Manifest</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Instance ID</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Activitiy Name</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Activity Details</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
					<Cell>
						<Data ss:Type="String">Messages</Data>
						<NamedCell ss:Name="_FilterDatabase"/>
					</Cell>
				
				</Row>
				
				
				<xsl:for-each select="current-group()/Events/LogEntry/Event">
					<xsl:variable name="fill">
						<xsl:choose>
							<xsl:when test="System/Level = 2 or System/Level = 1">
								<xsl:value-of select="'sError'"/>
							</xsl:when>
							<xsl:when test="System/Level = 3">
								<xsl:value-of select="'sWarning'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'sNone'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="fillB">
						<xsl:choose>
							<xsl:when test="System/Level = 2 or System/Level = 1">
								<xsl:value-of select="'sErrorB'"/>
							</xsl:when>
							<xsl:when test="System/Level = 3">
								<xsl:value-of select="'sWarningB'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'sNoneB'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<Row>
						<Cell ss:StyleID="{$fill}">
							<Data ss:Type="String">
								<xsl:choose>
									<xsl:when test="System/Level = 0">
										<xsl:text>Log Always</xsl:text>
									</xsl:when>
									<xsl:when test="System/Level = 1">
										<xsl:text>Critical</xsl:text>
									</xsl:when>
									<xsl:when test="System/Level = 2">
										<xsl:text>Error</xsl:text>
									</xsl:when>
									<xsl:when test="System/Level = 3">
										<xsl:text>Warning</xsl:text>
									</xsl:when>
									<xsl:when test="System/Level = 4">
										<xsl:text>Information</xsl:text>
									</xsl:when>
								</xsl:choose>
								
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fill}">
							<Data ss:Type="String">
								<xsl:value-of select="format-date(xs:date(substring-before(System/TimeCreated/@SystemTime,'T')), '[M01]/[D01]/[Y0001]')"/> - <xsl:value-of select="substring-before(substring-after(System/TimeCreated/@SystemTime,'T'),'.')"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fill}">
							<Data ss:Type="String">
								<xsl:value-of select="substring-after(System/Channel,'ThomsonReuters-ProcessManager-')"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fill}">
							<Data ss:Type="String">
								<xsl:value-of select="EventData/Data[@Name = 'InstanceID']"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fill}">
							<Data ss:Type="String">
								<xsl:value-of select="EventData/Data[@Name = 'Name']"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fillB}">
							<Data ss:Type="String">
								<xsl:value-of select="EventData/Data[@Name = 'Data']"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
						<Cell ss:StyleID="{$fillB}">
							<Data ss:Type="String">
								<xsl:value-of select="EventData/Data[@Name = 'message']"/>
							</Data>
							<NamedCell ss:Name="_FilterDatabase"/>
						</Cell>
					</Row>
				
				</xsl:for-each>
				
<!--			This section is supposed to add a link to the Event Viewer custom query for this list of logs.
			However, Excel seems to be blowing up the link and I opted to skip it for now. 
			- MK, 06/11/24-->
				
				<!--<xsl:variable name="theQuery" select="saxon:serialize(/DLSFaultLog/Events/Attributes[InstanceID = $insID]/FilterQuery/QueryList, 'htmlanswer')"/>-->
				<!--<xsl:variable name="theQuery" select="saxon:serialize(Events/Attributes[InstanceID = $insID]/FilterQuery/QueryList, 'htmlanswer')"/>
				
				<xsl:variable name="theNewQuery">
					<xsl:analyze-string select="$theQuery" regex="&quot;">
      <xsl:matching-substring>
        <!(1)** If the current character is a double quote, replace it with a single quote **(1)>
        <xsl:text>'</xsl:text>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <!(1)** Otherwise, output the current character as it is **(1)>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
				</xsl:variable>
					<Row>
						<xsl:variable name="theLink" select="encode-for-uri(replace(concat('C:\Windows\System32\EventVwr.exe /f:','&quot;', $theNewQuery, '&quot;'), '\\', '/'))"/>
						<Cell ss:HRef="{$theLink}">
							<Data>Click here to open Event Viewer with these logs.</Data>
						</Cell>
						<Cell>
							<Data><xsl:value-of select="$theLink"/></Data>
						</Cell>
					</Row>-->
				
			</Table>
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
				<PageSetup>
					<Header x:Margin="0.3"/>
					<Footer x:Margin="0.3"/>
					<PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
				</PageSetup>
				<Print>
					<ValidPrinterInfo/>
					<PaperSizeIndex>9</PaperSizeIndex>
					<HorizontalResolution>300</HorizontalResolution>
					<VerticalResolution>300</VerticalResolution>
				</Print>
				<Selected/>
				<FreezePanes/>
				<FrozenNoSplit/>
				<SplitHorizontal>1</SplitHorizontal>
				<TopRowBottomPane>1</TopRowBottomPane>
				<ActivePane>2</ActivePane>
				<Panes>
					<Pane>
						<Number>3</Number>
					</Pane>
					<Pane>
						<Number>2</Number>
					</Pane>
				</Panes>
				<ProtectObjects>False</ProtectObjects>
				<ProtectScenarios>False</ProtectScenarios>
			</WorksheetOptions>

		</Worksheet>
		</xsl:for-each-group>
		
		</xsl:template>
		
		</xsl:stylesheet>