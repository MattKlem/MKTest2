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
	

<xsl:variable name="TemplateList" select="dirs:GetDirectories('C:\Users\MattKlem\OneDrive - B365 - Datolitesolutions\Desktop\Workspaces\MC_Training\custom')"  xmlns:dirs="clitype:System.IO.Directory"/>

<!--1 = XAML (OnPrem) Templates, 2 = 3ET (Cloud) Templates-->
<xsl:variable name="wsType" select="1"/>

<!--Set these variables to whatever prefixes are used for labels and BTOs. You can specify multiple values by separating them with a pipe (|) character.-->
<xsl:variable name="lblKeyword" select="'lbl|LABEL_|Labels'"/>
<xsl:variable name="BTOPrefix" select="'BTO_|BTO|_BTO'"/>	

<!--A list of folders to exclude from analysis-->
<xsl:variable name="folderExclList" select="'Shared|Subdocs|Debug|Backups|SubDocs'"/>

<!--When using a distribution XAML, set this value to the filename of the distribution XAML-->
<xsl:variable name="distroXAML" select="'STOCK_Distribution.xaml|Distribution.xamlc'"/>

<!--1 = Full Details, 2 = Basic Details, 3 = Cloud Compatibility Only, 4 = Basic Details & Cloud Check
		**** This setting is ignored if wsType = 2
-->
<xsl:variable name="reportMode" select="1"/>

<!--These are all system variables. These should be left alone.-->
<xsl:variable name="TW" select="1440"/>
<xsl:variable name="fTypes" select="'docpngjpgdocxpdf'"/>
<xsl:variable name="imgTypes" select="'jpgpngjpegbmptifftif'"/>
<xsl:variable name="subDocTypes" select="'doc|docx|pdf'"/>


<!--<xsl:variable name="TemplateList" select="dirs:GetDirectories('C:\Users\MattKlem\OneDrive - B365 - Datolitesolutions\Work\3ET\Workspaces\FoleyCloudTest\StandardSolutions\custom')"  xmlns:dirs="clitype:System.IO.Directory"/>-->
<!--<xsl:variable name="TemplateList" select="dirs:GetDirectories('C:\Users\MattKlem\OneDrive - B365 - Datolitesolutions\Work\3ET\Workspaces\FoleyCloudPrep\custom')"  xmlns:dirs="clitype:System.IO.Directory"/>-->



</xsl:stylesheet>