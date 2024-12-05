<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:di="clitype:System.IO.DirectoryInfo" xmlns:path="clitype:System.IO.Path" xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:pin="http://www.elite.com/functions" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2" xmlns:saxon="http://saxon.sf.net/" xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" version="3.0">
	<xsl:preserve-space elements="*"/>
	<xsl:template name="BuildWordDoc">
		<xsl:param name="TemplatePath"/>
		<xsl:choose>
			<xsl:when test="$wsType = 1">
				<w:p/>
				<w:p>
					<w:pPr>
						<w:jc w:val="center"/>
					</w:pPr>
					<w:bookmarkStart w:id="{position()}" w:name="{tokenize(replace($TemplatePath,'_xaml',''),'\\')[position() = last()]}"/>
					<w:r>
						<w:rPr>
							<w:b/>
							<w:sz w:val="36"/>
						</w:rPr>
						<w:t>Datolite Template Report for <xsl:value-of select="tokenize(replace($TemplatePath,'_xaml','.xaml'),'\\')[position() = last()]"/>
						</w:t>
					</w:r>
					<w:bookmarkEnd w:id="{position()}"/>
				</w:p>
				<w:p/>
				<w:p/>
				<w:p/>
				<xsl:if test="$reportMode != 3">
					<xsl:call-template name="TemplateInformation">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="TemplateStats">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="XAMLDetails">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="CloudCheck">
					<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
				</xsl:call-template>
				<xsl:if test="$reportMode = 1">
					<xsl:call-template name="XAMLVarsArgs">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="FunctionList">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="MasterList">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="SubdocsImages">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="SharedComponents">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="Labels">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="BTO">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="GlobalVariables">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="FileInformation">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$wsType = 2">
				<w:p/>
				<w:p>
					<w:pPr>
						<w:jc w:val="center"/>
					</w:pPr>
					<w:bookmarkStart w:id="{position()}" w:name="{tokenize(replace($TemplatePath,'_3et',''),'\\')[position() = last()]}"/>
					<w:r>
						<w:rPr>
							<w:b/>
							<w:sz w:val="36"/>
						</w:rPr>
						<w:t>Datolite Template Report for <xsl:value-of select="tokenize(replace($TemplatePath,'_3et','.3et'),'\\')[position() = last()]"/>
						</w:t>
					</w:r>
					<w:bookmarkEnd w:id="{position()}"/>
				</w:p>
				<w:p/>
				<w:p/>
				<w:p/>
				<xsl:call-template name="TemplateInformation">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="TemplateStats">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="FunctionList">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="MasterList">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="SubdocsImages">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="SharedComponents">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="Labels">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="BTO">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="GlobalVariables">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
					<xsl:call-template name="FileInformation">
						<xsl:with-param name="TemplatePath" select="$TemplatePath"/>
					</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
