<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:tre="http://www.elite.com/functions" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template name="FunctionList">
		
		<xsl:param name="TemplatePath"/>
		<xsl:variable name="BaseFolder" select="tokenize($TemplatePath,'\\')[last()]"/>
		
		<w:p/>
		<xsl:variable name="Collection" select="collection(concat('file:///', encode-for-uri(replace($TemplatePath, '\\', '/')),'?select=*.(xsl|xml|link);recurse=yes'))"/>
		<xsl:variable name="DocumentNames">
			<xsl:for-each select="$Collection">
				<Document>
					<xsl:value-of select="document-uri(.)"/>
				</Document>
			</xsl:for-each>
		</xsl:variable>
			
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
						<!--<w:bookmarkStart w:id="5" w:name="FunctionDetails"/>-->
						<w:r>
							<w:rPr>
								<w:b/>
								<w:sz w:val="28"/><w:color w:val="ffffff"/>
							</w:rPr>
							<w:t>FUNCTION DETAILS</w:t>
						</w:r>
						<!--<w:bookmarkEnd w:id="5"/>-->
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
			<xsl:for-each select="$Collection">
				<xsl:variable name="p" select="position()"/>
				<xsl:variable name="numberOfDirectories" select="count(tokenize(document-uri(.), '/'))"/>
				<xsl:variable name="positionOfBaseFolder" select="index-of(tokenize(document-uri(.), '/'), $BaseFolder)"/>
				<xsl:variable name="funcFileName" select="tokenize(document-uri(.), '/')[last()]"/>
				<xsl:for-each select="//xsl:function">
					<xsl:variable name="numberOfVariables" select="count(descendant::*/@*[contains(.,'$')])"/>
					<xsl:variable name="localContext" select="."/>
					<xsl:variable name="funcPos" select="position()"/>
					<xsl:variable name="variablesUsed">
						<Variables>
							<xsl:for-each select="descendant::xsl:param/@name">
								<Variable>
									<xsl:value-of select="."/>
								</Variable>
							</xsl:for-each>
						</Variables>
					</xsl:variable>
					<w:tr>
						<w:trPr>
		</w:trPr>
						<!--ColumnNumber 1-->
						<w:tc>
							<w:tcPr>
								<w:tcW w:w="{$Col1}" w:type="dxa"/>
							</w:tcPr>
							<w:p>
								<w:pPr>
									<xsl:if test="$funcPos = 1">
										<w:keepNext/>
										<w:keepLines/>
									</xsl:if>
								</w:pPr>
								<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
									<w:t>Function Name: </w:t>
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
									<xsl:if test="$funcPos = 1">
										<w:keepNext/>
										<w:keepLines/>
									</xsl:if>
								</w:pPr>
								<w:r>
									<w:t>
										<xsl:value-of select="
                                    string-join((for $i in @name 
                                    return $i), ' ')"/>
									</w:t>
								</w:r>
							</w:p>
						</w:tc>
					</w:tr>
					<w:tr>
						<w:trPr>
		</w:trPr>
						<!--ColumnNumber 1-->
						<w:tc>
							<w:tcPr>
								<w:tcW w:w="{$Col1}" w:type="dxa"/>
							</w:tcPr>
							<w:p>
								<w:pPr>
									<xsl:if test="$funcPos = 1">
										<w:keepNext/>
										<w:keepLines/>
									</xsl:if>
								</w:pPr>
								<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
									<w:t>Located In: </w:t>
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
									<xsl:if test="$funcPos = 1">
										<w:keepNext/>
										<w:keepLines/>
									</xsl:if>
								</w:pPr>
								<w:r>
									<w:t>
										<xsl:value-of select="$funcFileName"/>
									</w:t>
								</w:r>
							</w:p>
						</w:tc>
					</w:tr>
					<w:tr>
						<w:trPr>
		</w:trPr>
						<!--ColumnNumber 1-->
						<w:tc>
							<w:tcPr>
								<w:tcW w:w="{$Col1}" w:type="dxa"/>
							</w:tcPr>
							<w:p>
								<w:pPr>
									<xsl:if test="$funcPos = 1">
										<w:keepNext/>
										<w:keepLines/>
									</xsl:if>
								</w:pPr>
								<w:r>
					<w:rPr>
						<w:b/>
					</w:rPr>
									<w:t>Available Parameters: </w:t>
								</w:r>
							</w:p>
						</w:tc>
						<!--ColumnNumber 2-->
						<w:tc>
							<w:tcPr>
								<w:tcW w:w="{$Col2}" w:type="dxa"/>
							</w:tcPr>
							<xsl:for-each select="distinct-values($variablesUsed/Variables/Variable)">
								<xsl:sort select="."/>
								<w:p>
									<w:pPr>
										<xsl:if test="$funcPos = 1">
											<w:keepNext/>
											<w:keepLines/>
										</xsl:if>
									</w:pPr>
									<w:r>
										<w:t>
											<xsl:value-of select="."/>
										</w:t>
									</w:r>
								</w:p>
							</xsl:for-each>
						</w:tc>
					</w:tr>
					<w:tr>
						<w:tc>
							<w:p/>
						</w:tc>
					</w:tr>
				</xsl:for-each>
			</xsl:for-each>

		<!--Shared functions						-->
		
		<xsl:variable name="Collection" select="collection(concat('file:///', encode-for-uri(replace($TemplatePath, '\\', '/')),'?select=*.(link);recurse=yes'))"/>
		<xsl:variable name="DocumentNames">
			<xsl:for-each select="$Collection">
				<Document>
					<xsl:value-of select="document-uri(.)"/>
				</Document>
			</xsl:for-each>
		</xsl:variable>
		<xsl:for-each select="$Collection">
			<xsl:variable name="p" select="position()"/>
			<xsl:variable name="numberOfDirectories" select="count(tokenize(document-uri(.), '/'))"/>
			<xsl:variable name="positionOfBaseFolder" select="index-of(tokenize(document-uri(.), '/'), $BaseFolder)"/>
			<xsl:variable name="funcFileName" select="replace(tokenize(document-uri(.), '/')[last()],'.link','')"/>
			<xsl:for-each select="//SourceComponentRalativePath">
				<xsl:variable name="fPath" select="replace(concat('file:///',string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\',.),'\\','/')"/>
				<xsl:variable name="isXSL" as="xs:boolean" select="if (tokenize($fPath,'\.')[position()=last()] = 'xsl') then true() else false()"/>
				<xsl:variable name="sharedFuncFile" select="if ($isXSL) then document($fPath) else x"/>
				<xsl:for-each select="$sharedFuncFile//xsl:function">
					<xsl:variable name="numberOfVariables" select="count(descendant::*/@*[contains(.,'$')])"/>
					<xsl:variable name="localContext" select="."/>
					<xsl:variable name="variablesUsed">
						<Variables>
							<xsl:for-each select="descendant::xsl:param/@name">
								<Variable>
									<xsl:value-of select="."/>
								</Variable>
							</xsl:for-each>
						</Variables>
					</xsl:variable>
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
										<w:t>Function Name: </w:t>
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
										<w:t>
											<xsl:value-of select="
                                    string-join((for $i in @name 
                                    return $i), ' ')"/>
										</w:t>
									</w:r>
								</w:p>
							</w:tc>
						</w:tr>
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
										<w:t>Located In: </w:t>
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
										<w:t>
											<xsl:value-of select="$funcFileName"/> (Shared)</w:t>
									</w:r>
								</w:p>
							</w:tc>
						</w:tr>
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
										<w:t>Available Parameters: </w:t>
									</w:r>
								</w:p>
							</w:tc>
							<!--ColumnNumber 2-->
							<w:tc>
								<w:tcPr>
									<w:tcW w:w="{$Col2}" w:type="dxa"/>
								</w:tcPr>
								<xsl:for-each select="distinct-values($variablesUsed/Variables/Variable)">
									<xsl:sort select="."/>
									<w:p>
										<w:r>
											<w:t>
												<xsl:value-of select="."/>
											</w:t>
										</w:r>
									</w:p>
								</xsl:for-each>
							</w:tc>
						</w:tr>
					<w:tr>
						<w:tc>
							<w:p/>
						</w:tc>
					</w:tr>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
				</w:tbl>
	</xsl:template>
</xsl:stylesheet>