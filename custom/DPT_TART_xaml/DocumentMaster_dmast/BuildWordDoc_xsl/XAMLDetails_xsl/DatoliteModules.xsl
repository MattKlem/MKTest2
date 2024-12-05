<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" 
xmlns:arch="http://expath.org/ns/archive"
xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dls="http://www.datolitesolutions.com/functions" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:file="http://expath.org/ns/file" version="2.0">
	<xsl:template name="DatoliteModules">
		<xsl:param name="TemplatePath"/>
		<xsl:variable name="sharedPath" select="concat(string-join(tokenize($TemplatePath,'\\')[position() &lt; last()],'\'),'\Shared')"/>
		<xsl:variable name="collHold" select="file:list($TemplatePath, true(), '*.*')"/>
		<xsl:variable name="Collection">
			<files>
				<xsl:for-each select="$collHold">
					<xsl:variable name="fullpath" select="concat($TemplatePath, '\',.)"/>
					<xsl:variable name="realpath" select="dls:getRP($fullpath, $sharedPath)"/>
					<file>
					<filepath>
						<xsl:value-of select="$realpath"/>
					</filepath>
					<ext><xsl:value-of select="lower-case(tokenize($realpath,'\.')[last()])"/></ext>
					</file>
				</xsl:for-each>
			</files>
		</xsl:variable>
		
		<dlsfile><xsl:copy-of select="$Collection/files/file"/></dlsfile>
		
		<xsl:variable name="XAMLName" select="replace($TemplatePath,'_xaml','.xaml')"/>
		<xsl:variable name="XAMLFQN" select="concat('file:///', replace($XAMLName, '\\', '/'))"/>
		<xsl:variable name="theContents" select="document($XAMLFQN)"/>
		
		<xsl:variable name="hasMR" select="if (count($theContents/Activity//*[contains(name(),'DraftEmail') or contains(name(),'FinalizeDraft') or contains(name(),'SendEmail')]) &gt; 0) then true() else false()"/>
		<xsl:variable name="hasAppend" select="if (count($Collection/files/file/filepath[matches(.,'Datolite.+Append')]) &gt; 0) then true() else false()" as="xs:boolean"/>
		<xsl:variable name="hasFL" select="if (count($Collection/files/file/filepath[matches(.,'Datolite.+FileLoader')]) &gt; 0) then true() else false()" as="xs:boolean"/>
		<xsl:variable name="hasForm" select="if (count($Collection/files/file/filepath[matches(.,'Datolite.+Formatting')]) &gt; 0) then true() else false()" as="xs:boolean"/>
		
		<xsl:variable name="dnHolder">
			<xsl:for-each select="$Collection/files/file[matches(lower-case(filepath),  '\.xsl|\.vdc') and not(matches(lower-case(filepath),  '\.cmeta'))]">
				
				<xsl:variable name="ext" select="tokenize(filepath, '\.')[last()]"/>
				<xsl:variable name="theDoc" select="if (lower-case($ext) = 'xsl') then document(filepath) else parse-xml(arch:extract-text(file:read-binary(filepath),'VisualDesignerXslt'))"/>
				
				<xsl:choose>
					<xsl:when test="$theDoc/*[local-name()='stylesheet']/namespace::*[contains(.,'clitype')]">
						<xsl:value-of select="'yes'"/>
						<xsl:for-each select="()"/>
					</xsl:when>
					<!--<xsl:otherwise>
						<xsl:value-of select="'no'"/>
						<xsl:for-each select="()"/>
					</xsl:otherwise>-->
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		
		
		
		<xsl:variable name="hasDotNet" select="if (contains($dnHolder, 'yes')) then true() else false()" as="xs:boolean"/>
		
		<w:tr>
			<!--ColumnNumber 1-->
			<w:tc>
				<w:tcPr>
					<w:tcBorders>
						<w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
					</w:tcBorders>
				</w:tcPr>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Datolite Appender:</w:t>
					</w:r>
				</w:p>
			</w:tc>
			<!--ColumnNumber 2-->
			<w:tc>
				<w:tcPr>
					<w:tcBorders>
						<w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
					</w:tcBorders>
				</w:tcPr>
				<xsl:copy-of select="dls:chkOrX(if ($hasAppend = true()) then 'TRUE' else 'FALSE')"/>
			</w:tc>
			<!--ColumnNumber 3-->
			<w:tc>
				<w:tcPr>
					<w:tcBorders>
						<w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
					</w:tcBorders>
				</w:tcPr>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Datolite Formatting Add-In:</w:t>
					</w:r>
				</w:p>
			</w:tc>
			<!--ColumnNumber 4-->
			<w:tc>
				<w:tcPr>
					<w:tcBorders>
						<w:top w:val="single" w:sz="4" wx:bdrwidth="10" w:space="0" w:color="auto"/>
					</w:tcBorders>
				</w:tcPr>
				<xsl:copy-of select="dls:chkOrX(if ($hasForm = true()) then 'TRUE' else 'FALSE')"/>
			</w:tc>
		</w:tr>
		<w:tr>
			<!--ColumnNumber 1-->
			<w:tc>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Datolite File Loader:</w:t>
					</w:r>
				</w:p>
			</w:tc>
			<!--ColumnNumber 2-->
			<w:tc>
				<xsl:copy-of select="dls:chkOrX(if ($hasFL = true()) then 'TRUE' else 'FALSE')"/>
			</w:tc>
			<!--ColumnNumber 3-->
			<w:tc>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>Datolite Mail Room:</w:t>
					</w:r>
				</w:p>
			</w:tc>
			<!--ColumnNumber 4-->
			<w:tc>
				<xsl:copy-of select="dls:chkOrX(if ($hasMR = true()) then 'TRUE' else 'FALSE')"/>
			</w:tc>
		</w:tr>
		<w:tr>
			<!--ColumnNumber 1-->
			<w:tc>
				<w:p>
					<w:r>
						<w:rPr>
							<w:b/>
						</w:rPr>
						<w:t>.NET Extensions:</w:t>
					</w:r>
				</w:p>
			</w:tc>
			<!--ColumnNumber 2-->
			<w:tc>
				<xsl:copy-of select="dls:chkOrX(if ($hasDotNet = true()) then 'TRUE' else 'FALSE')"/>
			</w:tc>
		</w:tr>
	</xsl:template>
</xsl:stylesheet>