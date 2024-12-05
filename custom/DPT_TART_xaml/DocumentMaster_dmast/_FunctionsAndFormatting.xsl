<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:dls="http://www.datolitesolutions.com/functions"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

		
	<xsl:function name="dls:chkShared">
		<xsl:param name="value"/>
		
	<xsl:choose>
		<xsl:when test="contains(lower-case($value),'.link')">
			<!--Shared-->
			<xsl:value-of select="concat(string-join(tokenize($value,'\.')[position() &lt; last()],'.'), ' (Shared)')"/> 
		</xsl:when>
		<xsl:otherwise>
			<w:t><xsl:value-of select="$value"/></w:t>
		</xsl:otherwise>
	</xsl:choose>
		
	</xsl:function>
	
	<xsl:function name="dls:chkOrX">
		<xsl:param name="value"/>
		
		<w:p>
			<w:r>
				<xsl:choose>
						<xsl:when test="$value = 'FALSE'">
							<w:t>X</w:t>
						</xsl:when>
						<xsl:otherwise>
							<w:sym w:font="Wingdings" w:char="F0FC" />
							<xsl:if test="contains($value,'(')">
								<!--This is a save parameter, parse it accordingly-->
								<w:t><xsl:value-of select="concat(' (',tokenize($value,'\(')[last()])"/></w:t>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
			</w:r>
		</w:p>		
		
	</xsl:function>
	
<!--	<xsl:function name="dls:getSharedPath">
		<xsl:param name="value"/>
		<xsl:param name="sharedPath"/>
			
		<xsl:variable name="linkFile" select="document($value)" as="node()*"/>
		<xsl:variable name="tmpPath" select="$linkFile/SmComponentLinkMetadata/SourceComponentRalativePath"/>
		<xsl:variable name="newSharedPath" select="string-join(tokenize($sharedPath,'\\')[position() &lt; last()],'\')"/>
		<xsl:value-of select="concat('file:///',replace(concat($newSharedPath,'/',$tmpPath), '\\', '/'))"/>
		
	</xsl:function>-->
	
	<xsl:function name="dls:getSharedPath">
        <xsl:param name="value"/>
        <xsl:param name="sharedPath"/>

<!--        <xsl:message>detect real=<xsl:value-of select="$value"/></xsl:message>-->

        <xsl:variable name="isDNPath" as="xs:boolean" select="if (contains($value, '\')) then true() else false()"/>
		
		
        <!--<xsl:variable name="linkFile">
            <xsl:choose>
                <xsl:when test="$isDNPath">
                    <xsl:variable name="aPath" select="concat('file:///', replace($value, '\\', '/'))"/>
                    <xsl:copy-of select="document($aPath)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="document($value)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>-->
		
		<xsl:variable name="linkFile" select="if ($isDNPath) then document(concat('file:///', replace($value, '\\', '/'))) else document($value)"/>
        
        <xsl:variable name="tmpPath" select="$linkFile/SmComponentLinkMetadata/SourceComponentRalativePath"/>

        <xsl:variable name="newSharedPath" select="string-join(tokenize($sharedPath, '\\')[position() &lt; last()], '\')"/>
		
        <!--<xsl:value-of select="concat('file:///', replace(concat($newSharedPath, '\', $tmpPath), '\\', '/'))"/>-->
		<xsl:value-of select="concat($newSharedPath, '\', $tmpPath)"/>

    </xsl:function>
	
	<xsl:function name="dls:getCount">
		
		<xsl:param name="Collection"/>
		<xsl:param name="type"/>
		
		
	</xsl:function>
	
	<xsl:function name="dls:isXML">
		<xsl:param name="value"/>
		
		<xsl:value-of select="if (matches(tokenize($value,'\.')[last()], 'xsl|xml|dmast|dprop|sprop')) then true() else false()"/>
		
	</xsl:function>
	<xsl:function name="dls:URLtoFP">
		<xsl:param name="value"/>
		
		<xsl:value-of select="replace(replace(replace($value,'file:///',''),'/','\\'),'%20',' ')"/>
		
	</xsl:function>
	
	<xsl:function name="dls:getRP">
		<xsl:param name="value"/>
		<xsl:param name="sharedPath"/>
		
		<xsl:variable name="linkPath" select="$value"/>
		<xsl:variable name="isShared" select="if (tokenize($linkPath,'\.')[last()] = 'link') then true() else false()"/>
		<xsl:value-of>
			<xsl:choose>
				<!--<xsl:when test="tokenize($linkPath,'\.')[last()] = 'xsl' or tokenize($linkPath,'\.')[last()] = 'xml' or tokenize($linkPath,'\.')[last()] = 'sprop' or tokenize($linkPath,'\.')[last()] = 'dprop' or tokenize($linkPath,'\.')[last()] = 'dmast'  or tokenize($linkPath, '\.')[last()] = 'vdc' or tokenize($linkPath, '\.')[last()] = 'vdc'">-->
				<xsl:when test="not($isShared)">
					<xsl:value-of select="replace($linkPath,'file:/','file:///')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="dls:getSharedPath($linkPath, $sharedPath)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:value-of>
	</xsl:function>
	
</xsl:stylesheet>