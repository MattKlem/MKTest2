<xsl:stylesheet 
xmlns:aml="http://schemas.microsoft.com/aml/2001/core" 
xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
xmlns:fo="http://www.w3.org/1999/XSL/Format" 
xmlns:dls="http://www.datolitesolutions.com/functions" 
xmlns:o="urn:schemas-microsoft-com:office:office" 
xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" 
xmlns:st1="urn:schemas-microsoft-com:office:smarttags" 
xmlns:v="urn:schemas-microsoft-com:vml" 
xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" 
xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:w10="urn:schemas-microsoft-com:office:word" 
xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" 
xmlns:FS="clitype:System.IO.Directory" 
xmlns:file="http://expath.org/ns/file"
xmlns:arch="http://expath.org/ns/archive"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"> 

	<xsl:template name="TemplateStats">
		
		<xsl:param name="TemplatePath"/>
		<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
		<xsl:variable name="codeComps" select="'\.(xsl|xslt|dmast|vdc|vdh|vdf|dprop|sprop)$'"/>
						
		<xsl:variable name="collHold" select="file:list($TemplatePath, true(), '*.*')"/>
		<xsl:variable name="Collection">
			<files>
				<xsl:for-each select="$collHold">
					<xsl:variable name="fullpath" select="concat($TemplatePath, '\',.)"/>
					<xsl:variable name="realpath" select="dls:getRP($fullpath, $sharedPath)"/>
					<filepath><xsl:value-of select="$realpath"/></filepath>
					<shared><xsl:value-of select="if (contains($fullpath, 'link')) then 1 else 0"/></shared>
					<filesize><xsl:value-of select="file:size($realpath)"/></filesize>
				</xsl:for-each>
			</files>
		</xsl:variable>
			
		<xsl:variable name="totCompSize" select="sum($Collection/files/filesize)"/>
		
		<!--Determine the line count of every component-->
		<xsl:variable name="compCount" select="count($Collection/files/filepath[not(contains(., 'cmeta'))])"/>
		
		<xsl:variable name="lc">
			<xsl:for-each select="$Collection/files/filepath[matches(.,$codeComps)]">
				<xsl:variable name="thecontents" select="if (matches(tokenize(.,'\.')[last()], 'vdc|vdf|vdh')) then parse-xml(arch:extract-text(file:read-binary(.),'VisualDesignerXslt')) else document(.)"/>
				<linecount><xsl:value-of select="string-length($thecontents) - string-length(translate($thecontents, '&#xA;', ''))"/></linecount>
				<filename><xsl:value-of select="."/></filename>
			</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="lineCount" select="sum($lc/linecount)"/>
			
			<!--Determine how many variables are declared-->

			<xsl:variable name="vc">
				<xsl:for-each select="$Collection/files/filepath[matches(.,$codeComps)]">
					<xsl:variable name="thecontents" select="if (matches(tokenize(.,'\.')[last()], 'vdc|vdf|vdh')) then parse-xml(arch:extract-text(file:read-binary(.),'VisualDesignerXslt')) else document(.)"/>
					<varcount><xsl:value-of select="count($thecontents//*[name() = 'xsl:variable'])"/></varcount>
				</xsl:for-each>
			</xsl:variable>
			
			<xsl:variable name="varCount" select="sum($vc/varcount)"/>
			
			<!--Determine how many conditional statements exist-->
			
			<xsl:variable name="cc">
				<xsl:for-each select="$Collection/files/filepath[matches(.,$codeComps)]">
					<xsl:variable name="thecontents" select="if (matches(tokenize(.,'\.')[last()], 'vdc|vdf|vdh')) then parse-xml(arch:extract-text(file:read-binary(.),'VisualDesignerXslt')) else document(.)"/>
					<concount><xsl:value-of select="count($thecontents//*[name() = 'xsl:if']) + count($thecontents//*[name() = 'xsl:when'])"/></concount>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="condCount" select="sum($cc/concount)"/>
			
			<!--Determine how many call-template commands are executed-->
			
			<xsl:variable name="cca">
				<xsl:for-each select="$Collection/files/filepath[matches(.,$codeComps)]">
					<xsl:variable name="thecontents" select="if (matches(tokenize(.,'\.')[last()], 'vdc|vdf|vdh')) then parse-xml(arch:extract-text(file:read-binary(.),'VisualDesignerXslt')) else document(.)"/>
					<callcount><xsl:value-of select="count($thecontents//*[name() = 'xsl:call-template'])"/></callcount>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="callCount" select="sum($cca/callcount)"/>
	
		<xsl:variable name="totFileSize">
			<xsl:choose>
				<xsl:when test="$totCompSize &gt;= 1073741824">
					<!--comp count is higher than 1 gig-->
					<xsl:variable name="tot" select="floor($totCompSize) div 1073741824"/>
					<xsl:variable name="tot2" select="floor($totCompSize) div 1048576"/>
					<xsl:value-of select="concat($tot, '.', round-half-to-even($tot2,2), ' GB')"/>
				</xsl:when>
				<xsl:when test="$totCompSize &gt;= 1048576">
					<!--comp count is higher than 1 meg-->
					<xsl:variable name="tot" select="floor($totCompSize) div 1048576"/>
					<xsl:variable name="tot2" select="floor($totCompSize) div 1024"/>
					<xsl:value-of select="concat($tot, '.', round-half-to-even($tot2,2), ' MB')"/>
				</xsl:when>
				<xsl:when test="$totCompSize &gt;= 1024">
					<!--comp count is higher than 1 kb-->
					<xsl:variable name="tot" select="floor($totCompSize) div 1024"/>
					<xsl:value-of select="concat(round-half-to-even($tot,0), ' KB')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
	
		
		
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
					<w:top w:w="10" w:type="dxa"/>
					<w:bottom w:w="10" w:type="dxa"/>
				</w:tblCellMar>
			</w:tblPr>
			<w:tblGrid>
				<w:gridCol w:w="{$Col1}"/>
				<w:gridCol w:w="{$Col2}"/>
				<w:gridCol w:w="{$Col3}"/>
				<w:gridCol w:w="{$Col4}"/>
			</w:tblGrid>
			<w:tr>
				<w:trPr>
					<w:tblHeader/>
				</w:trPr>
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
						<!--<w:bookmarkStart w:id="19" w:name="TemplateStatistics"/>-->
						<w:r>
							<w:rPr>
								<w:b/>
								<w:sz w:val="28"/><w:color w:val="ffffff"/>
							</w:rPr>
							<w:t>TEMPLATE STATISTICS</w:t>
						</w:r>
						<!--<w:bookmarkEnd w:id="19"/>-->
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
							<w:t>Line Count (approx):</w:t>
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
								<!--<xsl:value-of select="sum($RollingAmount/Stylesheet/BalanceCard/Amount)"/>-->
								<xsl:value-of select="$lineCount"/>
							</w:t>
						</w:r>
					</w:p>
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
							<w:t>XSL Variable Count:</w:t>
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
							<w:t>
								<xsl:value-of select="$varCount"/>
							</w:t>
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
							<w:t># of Components:</w:t>
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
								<xsl:value-of select="$compCount"/>
							</w:t>
						</w:r>
					</w:p>
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
							<w:t># of Calls:</w:t>
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
							<w:t>
								<xsl:value-of select="$callCount"/>
							</w:t>
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
							<w:t># of Conditions:</w:t>
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
								<xsl:value-of select="$condCount"/>
							</w:t>
						</w:r>
					</w:p>
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
							<w:t>Total Component(s) Size:</w:t>
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
							<w:t><xsl:value-of select="$totFileSize"/></w:t>
						</w:r>
					</w:p>
				</w:tc>
			</w:tr>
		</w:tbl>
		<w:p/>

	</xsl:template>
</xsl:stylesheet>