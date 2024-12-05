<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dls="http://www.datolitesolutions.com/functions"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
xpath-default-namespace="http://schemas.microsoft.com/netfx/2009/xaml/activities"


	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
 <xsl:template name="CloudCheck">
	 
	 <xsl:param name="TemplatePath"/>
	 
	 		<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
			<xsl:variable name="XAMLName" select="replace($TemplatePath,'_xaml','.xaml')"/>
			<xsl:variable name="XAMLFQN" select="concat('file:///', replace($XAMLName, '\\', '/'))"/>
			<xsl:variable name="theContents" select="document($XAMLFQN)"/>
			<xsl:variable name="stockDistro" select="if (matches($theContents/Activity//*[contains(name(),'ExecuteChildProcess')]/@ProcessPath,$distroXAML)) then true() else false()"/>	  
			
			<xsl:variable name="Collection" select="collection(concat('file:///', encode-for-uri(replace($TemplatePath, '\\', '/')),'?select=*.(link|xsl);recurse=yes'))"/>

				
		<!--General Properties
			<xsl:value-of select="count($sharedDoc//*[name() = 'xsl:call-template'])"/>
			
			-->
		
		<xsl:variable name="hasSQL" select="if (count($theContents/Activity//*[contains(name(),'ExecuteSql') or contains(name(),'InsertSqlIntoXml')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasExcel" select="if (count($theContents/Activity//*[contains(name(),'ConvertExcelDocument')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasSave">
			<xsl:choose>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')]) &gt; 0">
					<!--A save is being done, but what kind-->
					<xsl:choose>
						<!--Both debug and distro saves have been found (assumes debug data is saved as XML)-->
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) &gt; 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) &gt; 0 ">
							<xsl:value-of select="true()"/>
						</xsl:when>
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) = 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) &gt; 0 ">
							<!--Only debug data can be found-->
							<xsl:value-of select="false()"/>
						</xsl:when>
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) &gt; 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) = 0 ">
							<!--Only distro saves have been found-->
							<xsl:value-of select="true()"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable> 
		<xsl:variable name="hasDMS">
			<xsl:choose>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'iManageWork')]) &gt; 0">
					<!--  iManage -->
					<xsl:value-of select="'IMANAGE'"/>
				</xsl:when>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'NetDocuments')]) &gt; 0">
					<!-- Netdocs -->
					<xsl:value-of select="'NETDOCS'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="hasParallel" select="if (count($theContents/Activity//*[contains(name(),'Parallel')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasAdvWord" select="if (count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@DocumentPassword[. !='{x:Null}']) &gt; 0 or count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@EditingRestrictions[. != 0]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasAdvPDF">
			<xsl:choose>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@UserPassword[. != '{x:Null}']) &gt; 0 ">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@PfxFile [. != '{x:Null}']) &gt; 0 ">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@OwnerPassword [. != '{x:Null}']) &gt; 0 ">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@ArePermissionsSet [. != 'False']) &gt; 0 ">
					<xsl:value-of select="true()"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="false()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="hasEmailPriority" select="if (count($theContents/Activity//*[contains(name(),'Email')]/@Priority[. != 'Normal']) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasDLSMR" select="if (count($theContents/Activity//*[contains(name(),'DraftEmail') or contains(name(),'FinalizeDraft') or contains(name(),'SendEmail')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="dlsHolder">
			<xsl:element name="DLS">
			<xsl:for-each select="$Collection">
			<xsl:variable name="DocumentName" select="string-join(tokenize(document-uri(.), '/')[position() &gt; last() - 1], '\')"/>
			<xsl:variable name="linkPath" select="document-uri(.)"/>
			<xsl:variable name="realPath">
				<xsl:choose>
					<xsl:when test="tokenize($linkPath,'\.')[last()] = 'xsl'">
						<xsl:value-of select="$linkPath"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="dls:getSharedPath($linkPath, $sharedPath)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="tokenize($realPath,'\.')[last()] = 'xsl'">
				<xsl:variable name="fName" select="tokenize($realPath,'/')[last()]"/>
				<xsl:if test="matches($fName,'Datolite.+Appending')">
					<module>Datolite Appender</module>
				</xsl:if>
				<xsl:if test="matches($fName,'Datolite.+FileLoader')">
					<module>Datolite File Loader</module>
				</xsl:if>
				<xsl:if test="matches($fName,'Datolite.+Formatting')">
					<module>Datolite Formatting Add-In</module>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:if test="$hasDLSMR">
			<module>Datolite Mail Room</module>
		</xsl:if>
		</xsl:element>
		</xsl:variable>
		<xsl:variable name="hasDLS" select="if (count($dlsHolder//*[contains(name(),'module')]) &gt; 0) then true() else false()"/>
		
		<xsl:variable name="hasBreak" select="if (count($theContents/Activity//*[contains(name(),'BreakDocument')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasLog" select="if (count($theContents/Activity//*[contains(name(),'Log')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasAssVars" select="if (count($theContents/Activity//*[contains(name(),'AssignVariables')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasAssign" select="if (count($theContents/Activity//Assign) &gt; 0) then true() else false()"/>
		
		<xsl:variable name="hasTTX" select="if (count($theContents/Activity//*[contains(name(),'ConvertToXml')]) &gt; 0) then 
		concat('TRUE', if ($theContents/Activity//*[contains(name(),'ConvertToXml')]/@IsTextToXml = 'True') then ' (TTX)' else ' (DD)') else 'FALSE'"/>
		
		<xsl:variable name="hasPBag" select="if (count($theContents/Activity//*[contains(name(),'GetBagFromStore') or contains(name(),'GetPropertyBagUrl')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasExecWF" select="if (count($theContents/Activity//*[contains(name(),'ExecuteWorkflow') or contains(name(),'StartWorkflow') or contains(name(),'ExecuteChildProcess')]) &gt; 0) then true() else false()"/>
		
		
		<xsl:variable name="passCloud" select="if ($hasSQL or $hasExcel or $hasParallel or $hasAdvWord or $hasAdvPDF or @hasEmailPriority or $hasDLS or $hasSave or $hasBreak 
		or $hasTTX or $hasLog or $hasAssVars or $hasAssign or $hasPBag or $hasExecWF) then false() else true()" as="xs:boolean"/>

<w:p/>
		<w:tbl>
	<xsl:variable name="Col1" select="$TW * 1.5"/>
	<xsl:variable name="Col2" select="$TW * 3.5"/>
	<xsl:variable name="Col3" select="$TW * 2.5"/>
	<xsl:variable name="Col4" select="$TW * 2.5"/>
	<w:tblPr>
		<w:tblW w:w="0" w:type="dxa"/>
		<w:tblLayout w:type="Fixed"/>
		<w:tblCellMar>
			<w:left w:w="0" w:type="dxa"/>
			<w:right w:w="0" w:type="dxa"/>
			<w:top w:w="40" w:type="dxa"/>
			<w:bottom w:w="40" w:type="dxa"/>
		</w:tblCellMar>
	</w:tblPr>
	<w:tblGrid>
		<w:gridCol w:w="{$Col1}"/>
		<w:gridCol w:w="{$Col2}"/>
		<w:gridCol w:w="{$Col3}"/>
		<w:gridCol w:w="{$Col4}"/>
	</w:tblGrid>
	
	
	<w:tr>
		<w:tc>
				<w:tcPr>
				<w:gridSpan w:val="4"/>
				<w:tcBorders>
	<w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
	<w:left w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
	<w:bottom w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
	<w:right w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
</w:tcBorders>
<w:shd w:val="solid" w:color="0070c0" w:fill="auto"/>
			</w:tcPr>
			<w:p>
				<w:pPr>
					<w:jc w:val="center"/>
			
					<w:keepNext/>
					<w:keepLines/>
				</w:pPr>
				<!--<w:bookmarkStart w:id="25" w:name="DTDetails" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>3E TEMPLATES CLOUD COMPATIBILITY</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="25" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:tc>
			<w:p>
				<w:pPr>
										<w:keepNext/>
					<w:keepLines/>

				</w:pPr>
			</w:p>
		</w:tc>
	</w:tr>
	

	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
				<w:gridSpan w:val="4"/>
			</w:tcPr>
							<xsl:if test="$stockDistro">
					<w:p>
						<w:pPr>
												<w:keepNext/>
					<w:keepLines/>

						</w:pPr>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Cloud Compatible: </w:t>
					</w:r>
					<w:r>
						<w:t>Possibly</w:t>
					</w:r>
				</w:p>
				<w:p>
					<w:r>
						<w:tab/>
						<w:t>Distribution workflow in use. Please review template workflow for compatibility.</w:t>
					</w:r>
				</w:p><w:p/>
				</xsl:if>
			<xsl:choose>

			<xsl:when test="$passCloud">
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Cloud Compatible: </w:t>
					</w:r>
					<w:r>
						<w:t>True</w:t>
					</w:r>
				</w:p>
			</xsl:when>
			<xsl:otherwise>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Cloud Compatible: </w:t>
					</w:r>
					<w:r>
						<w:t>Unsupported features found</w:t>
					</w:r>
				</w:p>
				<w:p/>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Feature Details:</w:t>
					</w:r>
				</w:p>
				<w:p/>
				<xsl:if test="$hasSQL">
					<w:p>
						<w:r>
							<w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>SQL Activities Detected - Retrieval of external data via SQL is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'ExecuteSql']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t><xsl:value-of select="@Query"/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'ExecuteSql' or local-name() = 'InsertSqlIntoXml'][@SqlQuery != '[secQuery]']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t><xsl:value-of select="if (@SqlQuery != '') then @SqlQuery else @Query"/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="$hasExcel">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Excel Output Detected - Excel outputs are not supported in Cloud.</w:t>
						</w:r>
					</w:p>
					<w:p/>
					</xsl:if>
				<xsl:if test="$hasParallel">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Parallel Sequences Detected - Multiple output types via parallel are not supported in Cloud.</w:t>
						</w:r>
					</w:p>
					<w:p/>
				</xsl:if>
				<xsl:if test="$hasAdvWord">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Advanced Word Options Detected - Password protection and editing restrictions are not supported in Cloud.</w:t>
						</w:r>
					</w:p>
				<w:p/>
					</xsl:if>
				<xsl:if test="$hasAdvPDF = true()">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Advanced PDF Options Detected - Encryption, passwords, and editing restrictions are not supported in Cloud.</w:t>
						</w:r>
					</w:p>
				<w:p/>
					</xsl:if>
				<xsl:if test="$hasEmailPriority">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Non-Standard Email Priority Detected - Email priority is not supported in Cloud.</w:t>
						</w:r>
					</w:p>
				<w:p/>
					</xsl:if>
				<xsl:if test="$hasSave">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>File Path Save Detected - Saving files to a local file share are not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'SaveToDisk'][not(contains(@SavePath,'.xml'))]" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t><xsl:value-of select="@SavePath"/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="$hasDLS">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Datolite Modules Detected</w:t>
						</w:r>
					</w:p>
					<xsl:for-each select="$dlsHolder//*[contains(name(),'module')]">
						<w:p>
							<w:r>
								<w:tab/><w:tab/>
								<w:t><xsl:value-of select="."/></w:t>
							</w:r>
						</w:p>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="not($hasTTX = 'FALSE')">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Text to XML Conversion (TTX) detected. TTX is not supported in the Cloud.</w:t>
						</w:r>
					</w:p>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasBreak">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Document breaking is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'BreakDocument']/@Expression" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t><xsl:value-of select="."/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasLog">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Manual logging is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'Log']/@Message" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t><xsl:value-of select="."/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasLog">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Assign Variables activity detected. This type of variable capture is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'AssignVariables']/*[local-name() = 'AssignVariables.Variables']/*[local-name() = 'List']/*[local-name()='XpathVariable']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Variable Name: <xsl:value-of select="@Name"/></w:t><w:br/>
								<w:t>Variable Expression: <xsl:value-of select="@Expression"/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasAssign">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>A-B Assign Activity detected. This activity is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//Assign" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Variable: <xsl:value-of select="replace(replace(Assign.To/OutArgument,'\[',''),'\]','')"/></w:t><w:br/>
								<w:t>Assignment: <xsl:value-of select="Assign.Value/InArgument"/></w:t><w:br/>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasPBag">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Property Bag activities have been detected. Property Bags are not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'GetBagFromStore']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Bag Collected: <xsl:value-of select="@Name"/></w:t>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
					</xsl:if>
					<xsl:if test="$hasExecWF">
					<w:p>
						<w:r><w:rPr>
							<w:i/><w:b/>
						</w:rPr>
							<w:tab/>
							<w:t>Secondary workflow execution activity detected. One template calling another template is not supported in Cloud.</w:t><w:br/>
						</w:r>
					</w:p>
					<xsl:if test="count($theContents/Activity//*[local-name() = 'ExecuteWorkflow']) &gt; 0">
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'ExecuteWorkflow']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Workflow Name: <xsl:value-of select="@WorkflowName"/></w:t><w:br/>
								<w:t>Workflow Alias: <xsl:value-of select="@DisplayName"/></w:t>
								<xsl:if test="@WorkflowArgs != ''">
									<w:br/>
									<w:t>Workflow Arguments: <xsl:value-of select="@WorkflowArgs"/></w:t>
								</xsl:if>
							</w:r>
						</w:p>
					</xsl:for-each>
					<w:p/>
					</xsl:if>
					<xsl:if test="count($theContents/Activity//*[local-name() = 'StartWorkflow']) &gt; 0">
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'StartWorkflow']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Workflow Name: <xsl:value-of select="@WorkflowCode"/></w:t><w:br/>
								<w:t>Workflow Alias: <xsl:value-of select="@DisplayName"/></w:t>
								<xsl:if test="@WorkflowArguments != ''">
									<w:br/>
									<w:t>Workflow Arguments: <xsl:value-of select="@WorkflowArguments"/></w:t>
								</xsl:if>
							</w:r>
						</w:p>
					</xsl:for-each>
					<w:p/>
					</xsl:if>
					<xsl:if test="count($theContents/Activity//*[local-name() = 'ExecuteChildProcess']) &gt; 0">
					<xsl:for-each select="$theContents/Activity//*[local-name() = 'ExecuteChildProcess']" >
						<w:p>
							<w:pPr>
      							<w:ind w:left="1440" />
							</w:pPr>
							<w:r>
								<w:t>Workflow Path: <xsl:value-of select="@ProcessPath"/></w:t>
								<xsl:if test="@WorkflowArgs != ''">
									<w:br/>
									<w:t>Workflow Arguments: <xsl:value-of select="@WorkflowArgs"/></w:t>
								</xsl:if>
							</w:r>
						</w:p>
					</xsl:for-each>
				<w:p/>
				</xsl:if>
					</xsl:if>
				<w:p/>
				<w:p>
					<w:r>
						<w:rPr>
							<w:i/><w:b/>
						</w:rPr>
						<w:t>***NOTE: Please note that the above assessment is based on an automated review of the template code. A consultant should review the template specifics to confirm these findings.</w:t>
					</w:r>
				</w:p>
			</xsl:otherwise>
		</xsl:choose>
		</w:tc>
		
	</w:tr>
	
</w:tbl>


<w:p/>
		
		
		
	 
    </xsl:template>
	
</xsl:stylesheet>