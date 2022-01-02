<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
<body>
  <table id="moviesTable" border="1" class="indent">
  <thead>
    <tr bgcolor="#495057">
        <th style="text-align:center">Title</th>
        <th style="text-align:center">Director</th>
        <th style="text-align:center">Country</th>
        <th style="text-align:center">Company</th>
        <th style="text-align:center">Year</th>
        <th style="text-align:center">Select</th>
    </tr>    
  </thead>
  <tbody>
     <xsl:for-each select="//section">
         <tr>
            <td id="genre" colspan="6"> 
              <xsl:value-of select="@name" />
            </td>
         </tr>
    <xsl:for-each select="movie">
      <tr id="{position()}">
        <td><xsl:value-of select="title"/></td>
        <td><xsl:value-of select="director"/></td>
        <td><xsl:value-of select="country"/></td>
        <td><xsl:value-of select="company"/></td>
        <td><xsl:value-of select="year"/></td>
        <td align="right"><input name="movie0" type="checkbox" /></td>
      </tr>
    </xsl:for-each>
    </xsl:for-each>
    </tbody>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
