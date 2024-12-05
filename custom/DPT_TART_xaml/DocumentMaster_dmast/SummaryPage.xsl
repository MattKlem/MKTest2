<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:tre="http://www.elite.com/functions"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
	<xsl:template name="SummaryPage">
		
		<w:p/>
		
		<w:tbl>
	<xsl:variable name="Col1" select="$TW * 5"/>
	<xsl:variable name="Col2" select="$TW * 5"/>
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
				<w:bookmarkStart w:id="0" w:name="Summary" />
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>DATOLITE TEMPLATE ANALYSIS REPORT</w:t>
				</w:r>
				<w:bookmarkEnd w:id="0" />
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
	
	<xsl:for-each select="$TemplateList[not(matches(., $folderExclList))]">
	<w:tr>
		<w:tc>
			<w:tcPr>
				<w:gridSpan w:val="2"/>
			</w:tcPr>
			<w:p>
				<w:hlink w:dest="" w:bookmark="{tokenize(replace(.,if($wsType=1) then '_xaml' else '_3et',''),'\\')[position() = last()]}">
				<w:r>
					<w:rPr>
							<w:rStyle w:val="Hyperlink"/>
						</w:rPr>
					<w:t><xsl:value-of select="tokenize(replace(.,if($wsType=1) then '_xaml' else '_3et',''),'\\')[position() = last()]"/></w:t>
				</w:r>
				</w:hlink>
			</w:p>
		</w:tc>
	</w:tr>
		
		</xsl:for-each>

			</w:tbl>

	</xsl:template>
	
</xsl:stylesheet>