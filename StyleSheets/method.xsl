<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:MethodDescriptor">
<html>
	<head>
	<meta name="description" content="WSWC - Methods" />
	<title>WSWC - Methodology Data</title>
	<link rel="stylesheet" href="../styles/vendor.css" />
	<link rel="stylesheet" href="../styles/main.css" />
	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-96258816-1', 'auto');
	  ga('send', 'pageview');

	</script>
	</head>
	
<body>
	<div class="container">
	   <div class="header">
		<ul class="nav nav-pills pull-right">
			<li class=" active ">
			<a target="_self" title="About" href="http://wade.westernstateswater.org/about-wade/">About WaDE</a>
			</li>
			<li class=" ">
			<a target="_self" title="WaDEMaps" href="http://wade.westernstateswater.org/wade-by-location/">Back to WaDE By Map</a>
			</li>
			<li class=" ">
			<a target="_self" title="WaDEDataTypes" href="http://wade.westernstateswater.org/wade-by-datatype/">Back to WaDE by DataType</a>
			</li>
		</ul>
		<a href="http://www.westernstateswater.org" title="WSWC Home">
		<img src="../images/wswclogo.png" alt="WSWC logo" height="90"/>
		</a>
		<h1>Western States Water Council<br/>
		Water Data Exchange (WaDE) Methodology Information</h1>
	    </div>	
     
	<div class="row">
           <div class="col-md-10">
           	<div class="callout-note callout ng-isolate-scope" closeable="true">
           	<p>
                **NOTICE** For all data provided, please review the associated 
                methodology information thoroughly to discover data provenance 
                and quality before using, especially when comparing data between 
                states, organizations or applications.
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
   <p><b><h4>Organization: <xsl:value-of select="WC:OrganizationName"/></h4></b></p>
   
<xsl:apply-templates select="WC:Method"/>

</xsl:template> 

<xsl:template match="WC:Method">
	
 <xsl:choose>   
   	<xsl:when test="WC:MethodName">
		<p><h4> Methodology Name:  <xsl:value-of select="WC:MethodName"/></h4></p>
		<p><h4>Description:  <xsl:value-of select="WC:MethodDescriptionText"/></h4></p>
 		<p><table style="width:1000px">
     		<tr>
       		<th>Development Date</th>
       		<th>Method Type</th>
       		<th>Timescale</th>
       		<th>More Method Information</th>
       		<th>Resource Type</th>
       		<th>Applicable Areas</th>
     		</tr>
     		<xsl:for-each select="WC:MethodName">
			<tr>
			<td><xsl:value-of select="../WC:MethodDevelopmentDate"/></td>
			<td><xsl:value-of select="../WC:MethodTypeText"/></td>
			<td><xsl:value-of select="../WC:TimeScaleText"/></td>
			<td><a><xsl:attribute name="href">
						<xsl:value-of select="../WC:MethodLinkText"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						More Information</a></td>
			<td><xsl:value-of select="../WC:ResourceType/WC:ResourceTypeText"/></td>
			<td><xsl:value-of select="../WC:ApplicableAreas/WC:LocationNameText"/></td>
			</tr>
		</xsl:for-each>
		</table></p>
	</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:DataSource">		
		<p><table style="width:1000px">
     		<tr>
       		<th>Data Source Name</th>
       		<th>Data Source Description</th>
       		<th style="width:150px">Data Source Time Period - Start</th>
       		<th style="width:150px">Data Source Time Period - End</th>
       		<th>Data Source Information</th>
     		</tr>
     		<xsl:for-each select="WC:DataSource/WC:DataSourceName">
     		<xsl:sort select="WC:DataSource/WC:DataSourceName"/>
			<tr>
       			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceDescription"/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceTimePeriod/WC:TimePeriodStartDate"/></td>
			<td><xsl:value-of select="../../WC:DataSource/WC:DataSourceTimePeriod/WC:TimePeriodEndDate"/></td>
			<td><a><xsl:attribute name="href">
						<xsl:value-of select="../../WC:DataSource/WC:DataSourceLinkText"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						More Information</a></td>
			</tr>
		</xsl:for-each>
		</table></p>
		<div class="header">
		<ul class="nav nav-pills pull-right">
		</ul></div>
		</xsl:when>		
</xsl:choose>
</xsl:template> 
</xsl:stylesheet> 

