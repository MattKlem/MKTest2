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
	
 <xsl:template name="DistroProcParse">
	 
	 <xsl:param name="TemplatePath"/>
	 	 
			<xsl:variable name="XAMLFQN" select="$TemplatePath"/>
			<xsl:variable name="theContents" select="document($XAMLFQN)"/>
			
				
		<!--General Properties-->
		
		<xsl:variable name="hasSQL" select="if (count($theContents/Activity//*[contains(name(),'ExecuteSQL') or contains(name(),'InsertSqlIntoXml')]) &gt; 0) then 'TRUE' else 'FALSE'"/>
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
					<w:t>Name:</w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
					<w:t><xsl:value-of select="tokenize($TemplatePath,'/')[last()]"/></w:t>
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
<!--	<xsl:call-template name="DatoliteModules">
		<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
	</xsl:call-template>-->
	
</w:tbl>	 
    </xsl:template>
	
</xsl:stylesheet>