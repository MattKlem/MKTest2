<xsl:stylesheet xmlns:aml="http://schemas.microsoft.com/aml/2001/core"
	xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:tre="http://www.elite.com/functions"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core"
	xmlns:st1="urn:schemas-microsoft-com:office:smarttags" xmlns:v="urn:schemas-microsoft-com:vml"
	xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:w10="urn:schemas-microsoft-com:office:word"
	xmlns:wsp="http://schemas.microsoft.com/office/word/2003/wordml/sp2"
	xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
 <xsl:template name="FileInformation">

	 <xsl:param name="TemplatePath"/>
	 <xsl:variable name="BaseFolder" select="tokenize($TemplatePath,'\\')[last()]"/>
		
		        <xsl:variable name="Collection"
            select="collection(concat('file:///', encode-for-uri(replace($TemplatePath, '\\', '/')),'?select=*.(xsl|dmast|dprop|sprop|xml);recurse=yes;content-type=application/xml'))" as="node()*"/>

        <xsl:variable name="DocumentNames">
            <xsl:for-each select="$Collection">
                <Document>
                    <xsl:value-of select="document-uri(.)"/>
                </Document>
            </xsl:for-each>
        </xsl:variable>

		<w:p>
			<w:r>
				<w:br w:type="page"/>
			</w:r>
		</w:p>
        
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
				<!--<w:bookmarkStart w:id="9" w:name="ComponentDetails" />-->
				<w:r>
					<w:rPr>
						<w:b/>
						<w:sz w:val="28"/><w:color w:val="ffffff"/>
					</w:rPr>
					<w:t>TEMPLATE COMPONENT DETAILS</w:t>
				</w:r>
				<!--<w:bookmarkEnd w:id="9" />-->
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
	


        <xsl:for-each select="$Collection">
            <xsl:variable name="p" select="position()"/>
            <xsl:variable name="numberOfDirectories" select="count(tokenize(document-uri(.), '/'))"/>
            <xsl:variable name="positionOfBaseFolder" select="index-of(tokenize(document-uri(.), '/'), $BaseFolder)"/>
			
			<w:tr><w:tc>

            <xsl:for-each
                select="
                    let $i := tokenize(document-uri(.), '/')
                    return
                        (for $j in $i[position() &gt; index-of($i, $BaseFolder)]
                        return
                            $j || ':' || index-of($i, $j) - index-of($i, $BaseFolder))">
                <xsl:variable name="pp" select="position()"/>
                <xsl:variable name="PreviousDocumentName"
                    select="tokenize(($DocumentNames/Document)[position() = $p - 1], '/')[(index-of(tokenize(($DocumentNames/Document)[position() = $p - 1], '/'), $BaseFolder)) + $pp]"/>
                <xsl:variable name="CurrentDocumentName" select="tokenize(., ':')[1]"/>

                <xsl:if
                    test="($CurrentDocumentName != $PreviousDocumentName) or string-length($PreviousDocumentName) = 0">
                    <w:p>
                        <w:pPr>
							<w:pStyle w:val="Heading2"/>
                            <w:tabs>
                                <w:tab w:val="left"
                                    w:pos="{180 * (xs:double(if (tokenize(., ':')[2] castable as xs:double) then xs:double(tokenize(., ':')[2]) - 1 else 1))}"
                                />
                            </w:tabs>
							
                        </w:pPr>
                        
                        <xsl:choose>
                            <xsl:when test="$pp != ($numberOfDirectories - $positionOfBaseFolder)">
                                <w:r>
                                    <w:rPr>
                                        <w:i/>
                                    </w:rPr>
                                    <w:t><xsl:value-of select="let $i := tokenize(($DocumentNames/Document)[$p], '/') return string-join(for $j in $i[position() &gt; 1 and position() &lt; (count($i) - 0)] return $j, '\')"/></w:t>
                                </w:r>
                            </xsl:when>
                            <xsl:otherwise>
                                <w:r>
                                    <w:rPr>
                                        <w:b/>
                                    </w:rPr>
                                    <w:t>FILE NAME: <xsl:value-of select="$CurrentDocumentName"/></w:t>
                                </w:r>
                                <!--<w:r>
                                   <w:t>
                                       <xsl:value-of select="$CurrentDocumentName"/>
                                   </w:t>
                               </w:r>-->                               
                            </xsl:otherwise>
                        </xsl:choose>

                    </w:p>
                </xsl:if>
            </xsl:for-each>

            <xsl:for-each select="//xsl:template">
                <xsl:variable name="numberOfVariables" select="count(descendant::*/@*[contains(.,'$')])"/>
                <xsl:variable name="localContext" select="."/>
                
                <xsl:variable name="variablesUsed">
                    <Variables>
                        <xsl:for-each select="descendant::*/@*[contains(.,'$')]">
                            <xsl:analyze-string select="." regex="\$([\w|_]+)">
                                <xsl:matching-substring><Variable><xsl:value-of select="regex-group(1)"/></Variable></xsl:matching-substring>
                            </xsl:analyze-string>
                        </xsl:for-each>
                    </Variables>
                </xsl:variable>
                
                <w:p>
                    <w:pPr>
                        <w:tabs>
                            <w:tab w:val="left" w:pos="335"/>
                            <w:tab w:val="left" w:pos="770"/>
                        </w:tabs>
                        <w:ind w:left="335" w:hanging="335"/>
                    </w:pPr>
                    <w:r>
                        <w:tab/>
                        <w:t>Template: <xsl:value-of
                                select="
                                    string-join((for $i in @name | @select | @match
                                    return
                                        node-name($i) || ' = ' || $i), ' ')"
                            /></w:t>
                    </w:r>
                    <w:br/>
                    <w:r>
                        <w:t><xsl:value-of select="count(distinct-values($variablesUsed/Variables/Variable))"/> Variables Used:</w:t>
                    </w:r>
                    
                        <xsl:for-each select="distinct-values($variablesUsed/Variables/Variable)">
                            <xsl:sort select="."></xsl:sort>
                            <w:r>
                                <w:br/>
                                <w:tab/>
                                <w:t><xsl:value-of select="."/></w:t>
                            </w:r>
                            <w:r>
                                <w:rPr>
                                    <w:i/>
                                </w:rPr>
                                <w:t>   (<xsl:value-of select="if (sum(for $i in $localContext/descendant::*[local-name()='variable'] return if (normalize-space($i/@name) eq normalize-space(.)) then 1 else 0) = 0) then 'GLOBAL' else 'LOCAL'"/>)</w:t>
                            </w:r>       
                        </xsl:for-each>
                    

                </w:p>

            </xsl:for-each>
                 
			</w:tc></w:tr>

        </xsl:for-each>

		</w:tbl>
    </xsl:template>
	
</xsl:stylesheet>