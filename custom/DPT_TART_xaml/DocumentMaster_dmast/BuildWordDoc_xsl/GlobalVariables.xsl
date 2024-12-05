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
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
<xsl:template name="GlobalVariables">
      
	<xsl:param name="TemplatePath"/>
	<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
	
	
	<w:tbl>
	<xsl:variable name="Col1" select="$TW * 3.5"/>
	<xsl:variable name="Col2" select="$TW * 4"/>
	<xsl:variable name="Col3" select="$TW * 2.5"/>
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
	</w:tblGrid>
	<w:tr>
			<w:trPr>
					<w:tblHeader/>
				</w:trPr>
		<w:tc>
				<w:tcPr>
				<w:gridSpan w:val="3"/>
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
				<!--<w:bookmarkStart w:id="12" w:name="GlobalVariables" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>GLOBAL VARIABLES</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="12" />-->
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
	
	
	
      
      		        <!--<xsl:variable name="SharedVariables" as="node()*">-->
            <xsl:for-each
                select="collection(concat('file:///', encode-for-uri(replace($TemplatePath, '\\', '/')),'?select=*.(link|xsl);recurse=yes'))">
							
                <xsl:variable name="DocumentName"
                    select="string-join(tokenize(document-uri(.), '/')[position() &gt; last() - 1], '\')"/>
				
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
					<xsl:variable name="theDoc" select="document($realPath)"/>
					 <xsl:for-each
                    select="$theDoc//*[local-name() = 'variable'][not(exists(ancestor::*[local-name() = 'variable']))]">
                    <xsl:variable name="IsGlobal" as="xs:boolean"
                        select="local-name(parent::*) = 'stylesheet'"/>
                    <xsl:variable name="VariableName" select="@name"/>
					<xsl:variable name="Content" select="if (normalize-space(.) = '') then @select else normalize-space(.)"/>
					<xsl:variable name="lblFile" select="if (contains($realPath,'Shared')) then concat(tokenize($realPath,'/')[last()],' (Shared)') else tokenize($realPath,'/')[last()]"/>
					<xsl:if test="not(matches($VariableName, $BTOPrefix)) and not(matches($VariableName, $lblKeyword)) and $IsGlobal">
						<w:tr>
		<w:trPr>
		</w:trPr>
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
					<w:t><xsl:value-of select="$VariableName"/></w:t>
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
				</w:r>
				 <w:r>
                    <w:rPr>
                        <w:i/>
                    </w:rPr>
                    <w:t>Default Value: <xsl:value-of select="$Content"/></w:t>
                </w:r>
			</w:p>
		</w:tc>
				<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:r>
				</w:r>
				 <w:r>
                    <w:t><xsl:value-of select="$lblFile"/></w:t>
                </w:r>
			</w:p>
		</w:tc>

	</w:tr>
	
	</xsl:if>
				
                
                </xsl:for-each>

				</xsl:if>
               
            </xsl:for-each>
			</w:tbl>

<w:p/>


    </xsl:template>
	
</xsl:stylesheet>