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
xmlns:file="http://expath.org/ns/file"
xpath-default-namespace="http://schemas.microsoft.com/netfx/2009/xaml/activities"

	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
 <xsl:template name="XAMLDetails">
	 
	 <xsl:param name="TemplatePath"/>
	 <xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
	 	 
			<xsl:variable name="XAMLName" select="replace($TemplatePath,'_xaml','.xaml')"/>
			<xsl:variable name="XAMLFQN" select="concat('file:///', replace($XAMLName, '\\', '/'))"/>
			<xsl:variable name="theContents" select="document($XAMLFQN)"/>
			<xsl:variable name="stockDistro" select="if (matches($theContents/Activity//*[contains(name(),'ExecuteChildProcess')]/@ProcessPath,$distroXAML)) then 'TRUE' else 'FALSE'"/>	  

				
		<!--General Properties-->
		
		<xsl:variable name="hasSQL" select="if (count($theContents/Activity//*[contains(name(),'ExecuteSql') or contains(name(),'InsertSqlIntoXml')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasIC" select="if (count($theContents/Activity//*[contains(name(),'ImageConnect')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasBreak" select="if (count($theContents/Activity//*[contains(name(),'BreakDocument')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasTTX" select="if (count($theContents/Activity//*[contains(name(),'ConvertToXml')]) &gt; 0) then 
		concat('TRUE', if ($theContents/Activity//*[contains(name(),'ConvertToXml')]/@IsTextToXml = 'True') then ' (TTX)' else ' (DD)') else 'FALSE'"/>
		<xsl:variable name="outputType" select="if (string-join($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@SelectedOutputType,', ') != '') then string-join($theContents/Activity//*[contains(name(),'ConvertWordDocument')]/@SelectedOutputType,', ') else if (string-join($theContents/Activity//*[contains(name(),'ConvertExcelDocument')]/@SelectedOutputType,', ') != '') then string-join($theContents/Activity//*[contains(name(),'ConvertExcelDocument')]/@SelectedOutputType,', ') else ''"/>
		
		<!--Distribution Information-->
		<xsl:variable name="hasSave">
			<xsl:choose>
				<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')]) &gt; 0">
					<!--A save is being done, but what kind-->
					<xsl:choose>
						<!--Both debug and distro saves have been found (assumes debug data is saved as XML)-->
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) &gt; 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) &gt; 0 ">
							<xsl:value-of select="concat('TRUE (Distro / Debug) ', if ($outputType != '') then concat(' [',$outputType,']') else '')"/>
						</xsl:when>
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) = 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) &gt; 0 ">
							<!--Only debug data can be found-->
							<xsl:value-of select="'TRUE (Debug)'"/>
						</xsl:when>
						<xsl:when test="count($theContents/Activity//*[contains(name(),'SaveToDisk')][not(contains(@SavePath,'.xml'))]) &gt; 0 and count($theContents/Activity//*[contains(name(),'SaveToDisk')][contains(@SavePath,'.xml')]) = 0 ">
							<!--Only distro saves have been found-->
							<xsl:value-of select="concat('TRUE (Distro) ', if ($outputType != '') then concat(' [',$outputType,']') else '')"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'FALSE'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable> 
		<xsl:variable name="hasPrint" select="if (count($theContents/Activity//*[contains(name(),'PrintDocument')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasDDC" select="if (count($theContents/Activity//*[contains(name(),'DocumentCatalog')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasEmail" select="if (count($theContents/Activity//*[contains(name(),'Email')]/@Body) &gt; 0) then 'TRUE' else 'FALSE'"/>
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
					<xsl:value-of select="'X'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="hasTRAppend" select="if (count($theContents/Activity//*[contains(name(),'AppendDocument')]/@BatchID) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasPBag" select="if (count($theContents/Activity//*[contains(name(),'GetBagFromStore') or contains(name(),'GetPropertyBagUrl')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasAssVars" select="if (count($theContents/Activity//*[contains(name(),'AssignVariables')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasExecWF" select="if (count($theContents/Activity//*[contains(name(),'ExecuteWorkflow') or contains(name(),'StartWorkflow') or contains(name(),'ExecuteChildProcess')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasLog" select="if (count($theContents/Activity//*[contains(name(),'Log')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
		<xsl:variable name="hasAssign" select="if (count($theContents/Activity//Assign) &gt; 0) then 'TRUE' else 'FALSE'"/>
		
		
		
		<!--  General Properties -->
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
				</w:pPr>
				<!--<w:bookmarkStart w:id="1" w:name="DTDetails" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>DATA TRANSFORMATION &amp; DISTRIBUTION DETAILS</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="1" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:tc>
			<w:p/>
		</w:tc>
	</w:tr>
	
	<xsl:if test="$stockDistro = 'TRUE'">
		<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Dist. Workflow in Use: </w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($stockDistro)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		</w:tr>
		<w:tr>
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
				<w:gridSpan w:val="4"/>
			</w:tcPr>
			<w:p/>
			<w:p>
				<w:r>
					<w:rPr>
						<w:i/>
						<w:b/><w:sz w:val="24"/>
					</w:rPr>
					<w:t>Distribution Workflow Details</w:t>
				</w:r>
			</w:p>
			<w:p/>
		</w:tc>
	</w:tr>
	
	<!--Figure out the full path to the appropriate child distribution workflow-->
	
		
	<xsl:variable name="distroName">
		<xsl:for-each select="tokenize($distroXAML, '\|')">
			<xsl:if test="contains($theContents/Activity//*[contains(name(),'ExecuteChildProcess')]/@ProcessPath,.)">
				<xsl:value-of select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="collHold" select="file:list($TemplatePath, true(), '*.*')"/>
	
	<xsl:variable name="Collection">
			<files>
				<xsl:for-each select="$collHold">
					<xsl:variable name="fullpath" select="concat($TemplatePath, '\',.)"/>
					<xsl:variable name="realpath" select="dls:getRP($fullpath, $sharedPath)"/>
					<filepath><xsl:value-of select="$realpath"/></filepath>
				</xsl:for-each>
			</files>
		</xsl:variable>
		
	
	
	<xsl:variable name="theDistroPath" xpath-default-namespace="">
		<xsl:for-each select="$Collection/files/filepath">
			<xsl:if test="contains(.,$distroName)">
				<xsl:value-of select="."/>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:call-template name="DistroProcParse">
		<xsl:with-param name="TemplatePath" select="$theDistroPath"/>
	</xsl:call-template>
	<w:p>
		<w:br w:type="page"/>
	</w:p>
	</xsl:if>
	
	<w:p/>
	<w:p>
		<w:r>
			<w:rPr>
				<w:b/><w:i/><w:sz w:val="24"/>
			</w:rPr>
			<w:t><xsl:value-of select="tokenize($TemplatePath,'\\')[last()]"/> Details</w:t>
		</w:r>
	</w:p>
	<w:p/>
	
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Save:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasSave)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>DMS:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:t><xsl:value-of select="$hasDMS"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Print:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasPrint)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>TR Append:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasTRAppend)"/>
			
		</w:tc>
	</w:tr>
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Email:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasEmail)"/>
			
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>DDC:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasDDC)"/>
		</w:tc>
	</w:tr>
	
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Has SQL:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasSQL)"/>
			
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Source Breaking:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasBreak)"/>
		</w:tc>
	</w:tr>
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Has Image Connect:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasIC)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Text to XML Conversion:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
				
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasTTX)"/>
		</w:tc>
	</w:tr>
	
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Uses Property Bags:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasPBag)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Uses Assign Variables:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
				
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasAssVars)"/>
		</w:tc>
	</w:tr>
	
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Has ExecWF:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasExecWF)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>Custom Logs:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
				
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasLog)"/>
		</w:tc>
	</w:tr>
	
	<w:tr>
	
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t>A-B Assign Present:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($hasAssign)"/>
		</w:tc>
		<!--ColumnNumber 3-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			
			</w:tcPr>
			<w:p>
				<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
					<w:t></w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 4-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col4}" w:type="dxa"/>
				
			</w:tcPr>
			
		</w:tc>
	</w:tr>
	
	
	
	<xsl:call-template name="DatoliteModules">
		<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
	</xsl:call-template>
	
</w:tbl>	 
    </xsl:template>
	
</xsl:stylesheet>