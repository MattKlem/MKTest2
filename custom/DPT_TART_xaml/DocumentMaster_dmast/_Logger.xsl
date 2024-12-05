<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/" name="logger">
		<xsl:param name="logMsg"/>
		
		<!--Set this to the folder/file you want to save your logging details to-->
		<xsl:variable name="origPath" select="'C:\Temp\DLSXSL.log'"/>
		
		<!--URL encodes the file path-->
		<xsl:variable name="theLog" select="concat('file:///', encode-for-uri(replace($origPath, '\\', '/')))"/>
		
		<!--Checks if file exists and returns boolean-->
		<xsl:variable name="logExists" select="unparsed-text-available($theLog)"/>
		
		<!--Creates the log file-->
		<xsl:result-document href="{$theLog}" method="text" >
			
			<!--Modifies the log message to include a datetime--> 
			<xsl:variable name="logMsg" select="concat(current-dateTime(), ': ', $logMsg)"/>
			
			<!--Determine if the file needs to be created or appended to-->
			<xsl:choose>
				<xsl:when test="$logExists = true()">
					
					<!--File already exists so import the log data and add the new log message to the end-->
					<xsl:variable name="oldLog" select="unparsed-text($theLog)"/>
					<xsl:value-of select="concat($oldLog, '&#13;', $logMsg)"/>
					
				</xsl:when>
				<xsl:otherwise>
					
					<!--File does not exist so just log the message received, which will create the file-->
					<xsl:value-of select="$logMsg"/>
					
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:result-document>
		
	</xsl:template>
</xsl:stylesheet>