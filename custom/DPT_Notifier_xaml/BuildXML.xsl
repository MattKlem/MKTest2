<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
  <xsl:template name="BuildXML" match="/">
	  
    <DLSNotify>
      <Request>
        <isEmail>true</isEmail>
        <isTeams>true</isTeams>
        <TeamsData>
          <Type>1</Type>
          <Target>#x</Target>
          <Message>this is a message</Message>
          <CardBlock>x</CardBlock>
        </TeamsData>
        <EmailData>
          <To>matt.klem@datolitesolutions.com</To>
          <CC />
          <BCC />
          <From>DLS_3ET_Notifier@datolitesolutions.com</From>
          <Body>this is a body</Body>
          <Subject>NOTIFICATION</Subject>
          <Attachments>c:\temp\godzilla.pdf</Attachments>
        </EmailData>
      </Request>
    </DLSNotify>
	
  </xsl:template>
  
</xsl:stylesheet>