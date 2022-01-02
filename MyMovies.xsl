<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
<body>
  <h2>My Favorite Movies</h2>
  <table border="1">
    <tr bgcolor="#343a40">
     <xsl:for-each select="//section">
      <th colspan="4"> 
      <xsl:value-of select="@name" />
       </th>
    </tr>
    <xsl:for-each select="catalog/section/movie">
    <tr>
      <td><xsl:value-of select="title"/></td>
      <td><xsl:value-of select="director"/></td>
      <td><xsl:value-of select="country"/></td>
      <td><xsl:value-of select="company"/></td>
      <td><xsl:value-of select="year"/></td>
    </tr>
    </xsl:for-each>
  </table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
