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
	
 <xsl:template name="XAMLVarsArgs">
	 
	 <xsl:param name="TemplatePath"/>
	 
			<xsl:variable name="XAMLName" select="replace($TemplatePath,'_xaml','.xaml')"/>
			<xsl:variable name="XAMLFQN" select="concat('file:///', replace($XAMLName, '\\', '/'))"/>
			<xsl:variable name="theContents" select="document($XAMLFQN)"/>
			
		
<w:p/>
		
		
		<!--Arguments-->
		
		<!-- 3Col Table inserted from Solution Manager -->
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
				<!--<w:bookmarkStart w:id="2" w:name="WorkflowArguments" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>WORKFLOW ARGUMENTS</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="2" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:trPr>
			<w:tblHeader/>
		</w:trPr>
		<w:tc>
			<w:p>
				<w:pPr>
					<w:keepNext/>
	<w:keepLines/>
				</w:pPr>
			</w:p>
		</w:tc>
	</w:tr>
	<xsl:for-each select="$theContents/Activity/x:Members/x:Property">
	<w:tr>
		
			<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:pPr>
					<xsl:if test="position() = 1">
						<w:keepNext/>
						<w:keepLines/>
					</xsl:if>
			</w:pPr>
				<w:r>
					<w:t><xsl:value-of select="@Name"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col2}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				
				<w:pPr>
					<xsl:if test="position() = 1">
						<w:keepNext/>
						<w:keepLines/>
					</xsl:if>
			</w:pPr>
				<w:r>
					<w:t><xsl:value-of select="@Type"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
	</xsl:for-each>
</w:tbl>

<w:p/>

<w:tbl>
	<xsl:variable name="Col1" select="$TW * 3"/>
	<xsl:variable name="Col2" select="$TW * 4"/>
	<xsl:variable name="Col3" select="$TW * 3"/>
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
				<!--<w:bookmarkStart w:id="4" w:name="WorkflowVariables" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>WORKFLOW VARIABLES</w:t>
				</w:r>
				<!--<w:bookmarkStart w:id="4" w:name="WorkflowArguments" />-->
			</w:p>
		</w:tc>
	</w:tr>
	<w:tr>
		<w:trPr>
			<w:tblHeader/>
		</w:trPr>
		<w:tc>
			<w:p>
				<w:pPr>
						<w:keepNext/>
						<w:keepLines/>
				</w:pPr>
			</w:p>
		</w:tc>
	</w:tr>
	
	<xsl:for-each select="$theContents//Sequence"> <!--Needs to be sequences that contain variables-->
		<xsl:variable name="seqName" select="@DisplayName"/>
		<xsl:variable name="seqNum" select="position()"/>
		<xsl:for-each select="Sequence.Variables/Variable">
			
	<w:tr>
		<!--ColumnNumber 1-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col1}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:pPr>
					<xsl:if test="position() = 1">
						<w:keepNext/>
						<w:keepLines/>
					</xsl:if>
			</w:pPr>
				<w:r>
					<w:t><xsl:value-of select="@Name"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:pPr>
					<xsl:if test="position() = 1">
						<w:keepNext/>
						<w:keepLines/>
					</xsl:if>
			</w:pPr>
				<w:r>
					<w:t><xsl:value-of select="string-join(tokenize(@x:TypeArguments,':')[position() &gt; 1],':')"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
		<!--ColumnNumber 2-->
		<w:tc>
			<w:tcPr>
				<w:tcW w:w="{$Col3}" w:type="dxa"/>
			</w:tcPr>
			<w:p>
				<w:pPr>
					<xsl:if test="position() = 1">
						<w:keepNext/>
						<w:keepLines/>
					</xsl:if>
			</w:pPr>
				<w:r>
					<w:t><xsl:value-of select="$seqName"/></w:t>
				</w:r>
			</w:p>
		</w:tc>
	</w:tr>
	</xsl:for-each>
	</xsl:for-each>
</w:tbl>

      
	
	      
	 
	 
    </xsl:template>
	
</xsl:stylesheet>