<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dls="http://www.datolitesolutions.com/functions"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:file="http://expath.org/ns/file"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
<xsl:template name="TemplateInformation">
	<xsl:param name="TemplatePath"/>
	
	<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
	
		<xsl:variable name="collHold" select="file:list($TemplatePath, true(), '*.*')"/>
		<xsl:variable name="Collection">
			<files>
				<xsl:for-each select="$collHold">
					<file>
						<xsl:variable name="fullpath" select="concat($TemplatePath, '\',.)"/>
						<xsl:variable name="realpath" select="dls:getRP($fullpath, $sharedPath)"/>
						<filepath>
							<xsl:value-of select="$realpath"/>
						</filepath>
						<shared>
							<xsl:value-of select="if (contains($fullpath, 'link')) then 1 else 0"/>
						</shared>
						<filesize>
							<xsl:value-of select="file:size($realpath)"/>
						</filesize>
					</file>
				</xsl:for-each>
			</files>
		</xsl:variable>
	
	<!--<xsl:variable name="Collection" select="fsize:list($TemplatePath, true(), '*.link')"/>-->
	
	<xsl:variable name="BaseFolder" select="tokenize($TemplatePath,'\\')[last()]"/>

				 
				 <!--XAML / Template Detail variables-->
<xsl:variable name="XAMLPath" select="string-join(tokenize($TemplatePath,'\\')[position() != last()],'\')"/>

<!--<xsl:variable name="XAMLDetails" select="document(concat($XAMLPath,'\',replace($BaseFolder,'_xaml','.xaml'),'.wfmeta'))"/>-->
<xsl:variable name="XAMLDetails">
	<xsl:choose>
		<xsl:when test="$wsType = 1">
			<xsl:copy-of select="document(concat($XAMLPath,'\',replace($BaseFolder,'_xaml','.xaml'),'.wfmeta'))"/>
		</xsl:when>
		<xsl:when test="$wsType = 2">
			<xsl:copy-of select="document(concat($XAMLPath,'\',replace($BaseFolder,'_3et','.3et'),'.wfmeta'))"/>
		</xsl:when>
	</xsl:choose>
</xsl:variable> 

<!--<dding><xsl:copy-of select="$XAMLDetails"/></dding>-->

<xsl:variable name="templateDesc" select="$XAMLDetails/SmWorkflowMetadata/Description"/>

<xsl:variable name="templateIs3E" select="upper-case($XAMLDetails/SmWorkflowMetadata/EDG3EPublish)"/>
<xsl:variable name="templateCat" select="$XAMLDetails/SmWorkflowMetadata/Categories/EDGTemplateCategory"/>
<xsl:variable name="templateMatch" select="$XAMLDetails/SmWorkflowMetadata/Matches/Match/Value"/>

	

		
		<!-- 2Col Table inserted from Solution Manager -->
<w:tbl>
	<xsl:variable name="Col1" select="$TW * 1.5"/>
	<xsl:variable name="Col2" select="$TW * 8.5"/>
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
	</w:tblGrid>
	<w:tr>
		<w:tc>
			<w:tcPr>
				<w:gridSpan w:val="2"/>
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
				<!--<w:bookmarkStart w:id="0" w:name="TemplateDetails" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>TEMPLATE DETAILS</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="0" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:tc>
			<w:p/>
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
					<w:t>Template Name: </w:t>
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
					<w:t><xsl:value-of select="replace($BaseFolder,'_xaml','')"/></w:t>
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
					<w:t>Template Folder: </w:t>
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
					<w:t><xsl:value-of select="$XAMLPath"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
	
	<xsl:if test="$templateDesc != ''">
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
					<w:t>Template Description: </w:t>
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
					<w:t><xsl:value-of select="$templateDesc"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
</xsl:if>
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
					<w:t>3E Print Template: </w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX($templateIs3E)"/>
		</w:tc>
	</w:tr>
	<xsl:if test="$templateIs3E = 'TRUE'">
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
					<w:t>Template Category: </w:t>
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
					<w:t><xsl:value-of select="$templateCat"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
	</xsl:if>
	
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
					<w:t>Template Match: </w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			
			<xsl:for-each select="$templateMatch">
				<w:p>
					<w:r>
						<w:t><xsl:value-of select="."/></w:t>
					</w:r>
				</w:p>
			</xsl:for-each>
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
					<w:t>Shared Components: </w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX(if (count($Collection/files/file[shared = 1]/filepath) &gt; 0) then 'TRUE' else 'FALSE')"/>
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
					<w:t>VDCs Present: </w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<xsl:copy-of select="dls:chkOrX(if (count($Collection/files/file[matches(lower-case(filepath), 'vdc|vdf|vdh')]/filepath) &gt; 0) then 'TRUE' else 'FALSE')"/>
		</w:tc>
	</w:tr>

</w:tbl>

<w:p/>
		
		
		
	</xsl:template>
	
</xsl:stylesheet>