<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDECatalog">
<html>
     <head>
     	 <meta name="description" content="WSWC - WaDE Catalog" />
         <title>WSWC - WaDE Catalog</title>
         <link rel="stylesheet" href="../styles/vendor.css" />
         <link rel="stylesheet" href="../styles/main.css" />
         
    </head>
<body>

<div class="container">
	   <div class="header">
		<ul class="nav nav-pills pull-right">
			<li class=" ">
			
<!--TODO: Check link back to map interface.-->

			<a target="_self" title="Home" href="http://wswc.maps.arcgis.com/apps/MapJournal/index.html?appid=0559c438673a4c42bb29d91aaaa1cb9a">Back to Map</a>
			</li>
			<li class=" active ">
			<a target="_self" title="About" href="http://www.westernstateswater.org/wade">About</a>
			</li>
		</ul>
		<a href="http://www.westernstateswater.org" title="WSWC Home">
		<img src="../images/wswclogo.png" alt="WSWC logo" height="60"/>
		</a>
		<h1>Western States Water Council - Water Data Exchange (WaDE) Catalog</h1>
	    </div>
	    
       <div class="row">
        <div class="col-md-10">
          <div class="callout-note callout ng-isolate-scope" closeable="true">
            <p>
                Data shared within WaDE are organized by "reports," 
                which are yearly encapsulations of the data, either a water year 
                (Oct. 1st - Sep. 30th), an irrigation year (Nov. 1st - Oct. 31st),
                or a calendar year. There may be multiple reports for any given 
                year based on the methods used to generate that report.</p>
            <p>
                **NOTICE** For all data provided, please review the associated 
                methodology information thoroughly to discover data provenance 
                and quality before using, especially when comparing data between 
                states or organizations.
             </p>
          </div>
        </div>
       </div>
        
     <xsl:apply-templates select="WC:Organization"/>

   </div>     
 </body>
 </html>

</xsl:template>

<xsl:template match="WC:Organization">
	<hr></hr>
    <p><b><h4>Organization: <xsl:value-of select="WC:OrganizationName"/></h4></b></p>
    <p><h4>Geospatial Reporting Unit: <xsl:value-of select="WC:Report/WC:Location/WC:LocationType"/> -
    <xsl:value-of select="WC:Report/WC:Location/WC:LocationText"/></h4></p>

       <div class="row">
        <div class="col-md-10">
          <div class="callout-note callout ng-isolate-scope" closeable="true">
            <p>
                For a listing of methods used by <xsl:value-of select="WC:OrganizationName"/>
                and shared within WaDE, <a><xsl:attribute name="href">
			<xsl:value-of select="WC:WaDEURLAddress"/>
			<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
			<xsl:value-of select="WC:OrganizationIdentifier"/>
			<xsl:text disable-output-escaping="yes">&amp;methodname=ALL</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="TARGET">
			<xsl:text disable-output-escaping="yes">_blank</xsl:text>
			</xsl:attribute>click here</a>.
             </p>
          </div>
        </div>
       </div>     

<!--Test for any summary-level data -->

<xsl:if test="WC:Report/WC:Location/WC:DataAvailable/WC:DataCategory='SUMMARY'">

	<p>To retrieve ALL of <xsl:value-of select="WC:OrganizationName"/>'s 
	SUMMARY datasets by report: </p>
<table>
	<tr>
	<td>
	<table>
	<tr>
		<th>Report</th>
		<th>Data Category</th>
		<th>View Entire Report</th>
	</tr>
	
<xsl:apply-templates select="WC:Report/WC:Location/WC:DataAvailable/WC:DataCategory"/>

</table>
</td>
</tr>
</table>
</xsl:if>

<!--Start of non-all requests -->
<p></p>
	<p>To retrieve summary-level and detailed data by report and by data category and type:</p>
        <p><h6>*Note: Requests for DETAILED DATA may have more 
        extensive data-retrieval times. Please be patient while the query is retrieved to your browser. 
        The query retrieval could take several minutes depending on website traffic and your network speeds.
        Use the table below to access detailed datasets by report, data category, and data type.</h6></p>      

<table>
	<tr>
	<td>
	<table>
	<tr>
		<th>Report</th>
		<th>Data Category*</th>
		<th>Data Type</th>
		<th>View by Data Type</th>
	</tr>
	
<xsl:apply-templates select="WC:Report/WC:Location/WC:DataAvailable"/>

</table>
</td>
</tr>
</table>
</xsl:template> 

<xsl:template match="WC:Report/WC:Location/WC:DataAvailable/WC:DataCategory">
	<xsl:for-each select=".">
	<xsl:sort select="." order="descending"/>
		<tr>
	<xsl:choose>
		<xsl:when test=".='SUMMARY'">
			<td><xsl:value-of select="../../../WC:ReportIdentifier"/></td>
			<td><xsl:value-of select="."/></td>
			<td><a><xsl:attribute name="href">
				<xsl:value-of select="../../../../WC:WaDEURLAddress"/>
				<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetSummary/GetSummary.php?loctype=</xsl:text>
				<xsl:value-of select="../../WC:LocationType"/>		
				<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
				<xsl:value-of select="../../WC:LocationText"/>		
				<xsl:text disable-output-escaping="yes">&amp;orgid=</xsl:text>
				<xsl:value-of select="../../../../WC:OrganizationIdentifier"/>		
				<xsl:text disable-output-escaping="yes">&amp;reportid=</xsl:text>
				<xsl:value-of select="../../../WC:ReportIdentifier"/>			
				<xsl:text disable-output-escaping="yes">&amp;datatype=ALL</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="TARGET">
				<xsl:text disable-output-escaping="yes">_blank</xsl:text>
				</xsl:attribute>
				All Summary Data</a></td>
		</xsl:when>
		
<!--	Uncomment these lines if the "ALL" retrieval speeds for Detailed Data get faster...

<xsl:otherwise>
			<td><xsl:value-of select="../../../WC:ReportIdentifier"/></td>
			<td><xsl:value-of select="."/></td>
			<td><a><xsl:attribute name="href">
				<xsl:value-of select="../../../../WC:WaDEURLAddress"/>
				<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetDetail/GetDetail.php?reportid=</xsl:text>
				<xsl:value-of select="../../../WC:ReportIdentifier"/>
				<xsl:text disable-output-escaping="yes">&amp;loctype=</xsl:text>
				<xsl:value-of select="../../WC:LocationType"/>
				<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
				<xsl:value-of select="../../WC:LocationText"/>
				<xsl:text disable-output-escaping="yes">&amp;datatype=ALL</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="TARGET">
				<xsl:text disable-output-escaping="yes">_blank</xsl:text>
				</xsl:attribute>
				All Detailed Data</a></td>
		</xsl:otherwise>
-->
	</xsl:choose>
	</tr>
	</xsl:for-each>
</xsl:template>
	
<xsl:template match="WC:Report/WC:Location/WC:DataAvailable">
	<xsl:for-each select="WC:DataTypes/WC:DataType">
	<xsl:sort select="." order="ascending"/>
	
		<tr>
		<td><xsl:value-of select="../../../../WC:ReportIdentifier"/></td>
		<td><xsl:value-of select="../../WC:DataCategory"/></td>
		<td><xsl:value-of select="."/></td>
		
	<xsl:choose>
		<xsl:when test="../../WC:DataCategory='SUMMARY'">
			<td><a><xsl:attribute name="href">
			<xsl:value-of select="../../../../../WC:WaDEURLAddress"/>
				<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetSummary/GetSummary.php?loctype=</xsl:text>
						<xsl:value-of select="../../../WC:LocationType"/>
						<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
						<xsl:value-of select="../../../WC:LocationText"/>
						<xsl:text disable-output-escaping="yes">&amp;orgid=</xsl:text>
						<xsl:value-of select="../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;reportid=</xsl:text>
						<xsl:value-of select="../../../../WC:ReportIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;datatype=</xsl:text>
						<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						View Data</a></td>
				</xsl:when>
				<xsl:otherwise>
					<td><a><xsl:attribute name="href">
					<xsl:value-of select="../../../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetDetail/GetDetail.php?reportid=</xsl:text>
						<xsl:value-of select="../../../../WC:ReportIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;loctype=</xsl:text>
						<xsl:value-of select="../../../WC:LocationType"/>
						<xsl:text disable-output-escaping="yes">&amp;loctxt=</xsl:text>
						<xsl:value-of select="../../../WC:LocationText"/>
						<xsl:text disable-output-escaping="yes">&amp;datatype=</xsl:text>
						<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						View Data</a></td>
				</xsl:otherwise>
	</xsl:choose>	
	</tr>

</xsl:for-each>
</xsl:template> 
</xsl:stylesheet> 

