<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
<body>
  <h2>My Favorite Movies</h2>
  <table  id="moviesTable" border="1" class="indent">
  <thead>
    <tr bgcolor="#green">
        <th style="text-align:right">Title</th>
        <th style="text-align:right">Director</th>
        <th style="text-align:right">Country</th>
        <th style="text-align:right">Company</th>
        <th style="text-align:right">Year</th>
    </tr>    
  </thead>
  <tbody>
     <xsl:for-each select="//section">
         <tr>
            <td colspan="6"> 
              <xsl:value-of select="@name" />
            </td>
         </tr>
    <xsl:for-each select="movie">
      <tr>
        <td align="right"><input name="item0" type="checkbox" /></td>
        <td><xsl:value-of select="title"/></td>
        <td><xsl:value-of select="director"/></td>
        <td><xsl:value-of select="country"/></td>
        <td><xsl:value-of select="company"/></td>
        <td><xsl:value-of select="year"/></td>
      </tr>
    </xsl:for-each>
    </xsl:for-each>
    </tbody>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
