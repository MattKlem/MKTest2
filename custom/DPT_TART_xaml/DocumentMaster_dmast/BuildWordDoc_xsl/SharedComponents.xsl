<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" 
xmlns:dls="http://www.datolitesolutions.com/functions" 
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
xmlns:file="http://expath.org/ns/file"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
	<xsl:template name="SharedComponents">
		
		<xsl:param name="TemplatePath"/>
		<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
		
		<xsl:variable name="collHold" select="file:list($TemplatePath, true(), '*.*')"/>
		<xsl:variable name="Collection">
			<files>
				<xsl:for-each select="$collHold">
					<file>
					<xsl:variable name="fullpath" select="concat($TemplatePath, '\',.)"/>
					<xsl:variable name="realpath" select="dls:getRP($fullpath, $sharedPath)"/>
					<filepath><xsl:value-of select="$realpath"/></filepath>
					<shared><xsl:value-of select="if (contains($fullpath, 'link')) then 1 else 0"/></shared>
					</file>
				</xsl:for-each>
			</files>
		</xsl:variable>
		
		<xsl:if test="count($Collection/files/file[shared = 1]) &gt; 0">
		
	<w:tbl>
	<xsl:variable name="Col1" select="$TW * 5"/>
	<xsl:variable name="Col2" select="$TW * 5"/>
	<w:tblPr>
		<w:tblW w:w="0" w:type="dxa"/>
		<w:tblLayout w:type="Fixed"/>
		<w:tblCellMar>
			<w:left w:w="0" w:type="dxa"/>
			<w:right w:w="0" w:type="dxa"/>
			<w:top w:w="10" w:type="dxa"/>
			<w:bottom w:w="10" w:type="dxa"/>
		</w:tblCellMar>
	</w:tblPr>
	<w:tblGrid>
		<w:gridCol w:w="{$Col1}"/>
		<w:gridCol w:w="{$Col2}"/>
	</w:tblGrid>
	<w:tr>
		<w:trPr>
					<w:tblHeader/>
				</w:trPr>
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
					<w:keepNext/>
						<w:keepLines/>
				</w:pPr>
				<!--<w:bookmarkStart w:id="8" w:name="SharedComponents" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>SHARED COMPONENTS</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="8" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:trPr>
					<w:tblHeader/>
				</w:trPr>
		<w:tc>
			<w:p/>
		</w:tc>
	</w:tr>
	
	<xsl:for-each select="$Collection/files/file[shared = 1]">
		
	

<w:tr>
		<w:trPr>
		</w:trPr>
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:gridSpan w:val="2"/>
			</w:tcPr>

		
			 <w:p>
				 <w:r>
						 <w:t><xsl:value-of select="filepath"/></w:t>
				 </w:r>
			 </w:p>
			
			</w:tc>
				</w:tr>
	
				</xsl:for-each>
		
	</w:tbl>

		
<w:p/>

</xsl:if>
	</xsl:template>
	

	
</xsl:stylesheet>