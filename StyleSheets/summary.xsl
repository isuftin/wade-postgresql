<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDE">
   <html>
	<head>
		<meta name="description" content="WSWC - Summaries" />
		<title>WSWC - Summary Data</title>
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>	
   			 
    		<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:WaterUseSummary">

		<script type="text/javascript">
      			google.charts.load('current', {packages: ['corechart']});
      			google.charts.setOnLoadCallback(drawVisualization);
      			
      			function drawVisualization() {
          		var data = new google.visualization.arrayToDataTable([
        		['Water Use Categories', 'Acre Feet Per Year (AFY)'],
			<xsl:for-each select="WC:WaterUse">
			<xsl:sort select="WC:WaterUseTypeName"/>
         		  ['<xsl:value-of select="WC:WaterUseTypeName"/>',<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
        		]);
        
        		var options = {title:'Water Use Categories', width:600,height:300,is3D:true,chma:[0,0,0,0],legend:{position:'right'},colors:['#A2CCC1', '#FFE8AA', '#E8DE67', '#E57152', '#4D2B2F']}; 		
        		var chart = new google.visualization.PieChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>WaterUse<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data, options);
        		}
		</script>
	
		</xsl:for-each>

		<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:DerivedWaterSupplySummary">
		<script type="text/javascript">
      			google.charts.load('current', {packages: ['corechart']});
      			google.charts.setOnLoadCallback(drawVisualization);

      			function drawVisualization() {
               	var data = new google.visualization.arrayToDataTable([
        		['Water Supply Types', 'Acre Feet Per Year (AFY)'],
			<xsl:for-each select="WC:DerivedWaterSupplyType">
			<xsl:sort select="WC:WaterSupplyTypeName"/>
         		  ['<xsl:value-of select="WC:WaterSupplyTypeName"/>',<xsl:value-of select="WC:SupplyAmountSummary/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
			]);
        		var options = {title:'Water Supply Types',chartArea:{left:150,top:15,width:'75%',height:'80%'},width:620,height:300,is3D:false,chma:[0,0,0,0],legend:{position:'bottom'},colors:['#A2CCC1', '#FFE8AA', '#E8DE67', '#E57152', '#4D2B2F']};
   		        var chart = new google.visualization.BarChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>WaterSupply<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data,options);
   		        }
  		</script>
   		</xsl:for-each>
	
      		<xsl:for-each select="WC:Organization/WC:Report/WC:ReportingUnit/WC:AllocationSummary">
		<script type="text/javascript">
      			google.charts.load('current', {packages: ['corechart']});
      			google.charts.setOnLoadCallback(drawVisualization);

      			function drawVisualization() {
               	var data = new google.visualization.arrayToDataTable([
        		['Allocation Beneficial Use Percentages', 'Acre Feet Per Year (AFY)'],
			<xsl:for-each select="WC:AllocationUse">
			<xsl:sort select="WC:AllocationUseTypeName"/>
         		  ['<xsl:value-of select="WC:AllocationUseTypeName"/>',<xsl:value-of select="WC:AllocationAmountSummary/WC:AmountNumber"/>]
			  <xsl:choose>
    				<xsl:when test="position() != last()">,</xsl:when>
  			</xsl:choose>
			</xsl:for-each>
			]);
        		var options = {title:'Allocated Beneficial Use Percentage',width:600,height:300,is3D:true,chma:[0,0,0,0],legend:{position:'right'},colors:['#A2CCC1', '#FFE8AA', '#E8DE67', '#E57152', '#4D2B2F']};
   		        new google.visualization.PieChart(document.getElementById('<xsl:value-of select="../../WC:ReportIdentifier"/>Allocation<xsl:value-of select="../WC:ReportingUnitIdentifier"/>')).draw(data,options);
   		        }
      		</script>
      		</xsl:for-each>
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
		Water Data Exchange (WaDE) Summary Data</h1>
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

	<hr></hr>
    <p><b><h4>Organization: <xsl:value-of select="WC:OrganizationName"/></h4></b></p>    
    <p><h4>Location Information: <xsl:value-of select="WC:Report/WC:ReportingUnit/WC:ReportingUnitName"/> -
    <xsl:value-of select="WC:Report/WC:ReportingUnit/WC:ReportingUnitTypeName"/> -
    <xsl:value-of select="WC:Report/WC:ReportingUnit/WC:ReportingUnitIdentifier"/></h4></p>
   
<xsl:apply-templates select="WC:Report"/>
</xsl:template> 

<xsl:template match="WC:Report">

<!--TODO: Ensure that each WFS shared by your organization is publically available,
i.e. a user does not need to log in to a website/provide credentials to access a map
or the JSON, geoJSON, etc. -->

<!--Test for any WFS-->

<xsl:if test="WC:GeospatialReference/WC:WFSType/WC:WFSDataCategory='SUMMARY'">

	<p><h4>State Agency Maps and Web Feature Services (WFS):</h4>
	<table style="width:300px">
		<tr>
		<th></th>
		</tr>
		<xsl:for-each select="WC:GeospatialReference/WC:WFSType">
		<tr>
   			<td><a><xsl:attribute name="href">
   				<xsl:value-of select="WC:WFSAddressLink"/>
   				</xsl:attribute>
   				<xsl:attribute name="TARGET">
   				<xsl:text disable-output-escaping="yes">
   				_blank</xsl:text>
   				</xsl:attribute><xsl:value-of select="WC:WFSTypeName"/></a></td>
   		</tr>
       </xsl:for-each>
   </table></p>
</xsl:if>

<xsl:for-each select="WC:ReportingUnit">
     	<p>This summary is relevant for the reporting year: <xsl:value-of select="../WC:ReportingYear"/> - 
     	<xsl:value-of select="../WC:YearType"/></p>
   	<p>These data were reported on: <xsl:value-of select="../WC:ReportingDate"/></p>
	<xsl:choose>
		<xsl:when test="WC:AvailabilitySummary">
   		<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo">
		<p><b><u><h4>Water Availability Summary</h4></u></b></p></button>
  		<div id="demo" class="collapse">
		<p><table style="width:1600px">
     		<tr>
       		<th>Availability Type</th>
       		<th>Fresh/Saline</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>GIS Feature</th>
       		<th>Amount</th>
       		<th>Units</th>
       		<th>Amount Methodology</th>
       		<th>Metric Name</th>
       		<th>Metric Value</th>
       		<th>Scale Max</th>
       		<th>Metric Methodology</th>
     		</tr>
     		<xsl:for-each select="WC:AvailabilitySummary">
		<xsl:sort select="WC:AvailabilityTypeName"/>
			<tr>
       		<td><xsl:value-of select="WC:AvailabilityTypeName"/></td>
			<td><xsl:value-of select="WC:FreshSalineIndicator"/></td>
			<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<!--Test for availability WFS. If yes, add availability GIS hyperlink. If no, omit hyperlink-->			
			<td><xsl:choose>
				<xsl:when test="../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='AVAILABILITY'">
				<a><xsl:attribute name="href">
						<xsl:value-of select="../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
						<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
						<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:otherwise>
			</xsl:choose></td>
			<xsl:choose>
				<xsl:when test="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:AmountNumber">
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:AmountNumber, '#,###.##','num')"/></td>
					<td>acre feet/year</td>
					<td><a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityAmount/WC:Method/WC:MethodName"/></a></td>
				</xsl:when>
				<xsl:otherwise>
					<td></td><td></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricName">
					<td><xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricName"/></td>
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricValue, '#,###','num')"/></td>
					<td><xsl:value-of select="format-number(WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:MetricScaleNumber, '#,###','num')"/></td>
					<td><a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:AvailabilityEstimate/WC:AvailabilityMetric/WC:Method/WC:MethodName"/></a></td>
				</xsl:when>
				<xsl:otherwise>
					<td></td><td></td><td></td><td></td>
				</xsl:otherwise>
			</xsl:choose>
			</tr>
		</xsl:for-each>
		</table></p></div>
		<div class="header">
		<ul class="nav nav-pills pull-right">
		</ul></div>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:WaterUseSummary">	
   			<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo1">
   			<p><b><u><h4>Water Use Summary</h4></u></b></p></button>
   			<div id="demo1" class="collapse">  
			<table>
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>WaterUse<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table style="width:1600px">
     			<tr>
			<th>Beneficial Use</th>
       			<th>Consumptive Use?</th>
       			<th>Fresh/Saline</th>
       			<th>Source Type</th>
       			<th>Irrigation Type</th>
       			<th>Acres Irrigated</th>
       			<th>Crop Type</th>
       			<th>Population Served</th>
       			<th>Power Generated (MWH)</th>       			
       			<th>Acre-Feet Per Year (AFY)</th>
       			<th>Start Date</th>
       			<th>End Date</th>
       			<th>GIS Feature</th>
       			<th>Water Use Methodology</th>
			</tr>
			<xsl:for-each select="WC:WaterUseSummary/WC:WaterUse">
			<xsl:sort select="WC:WaterUseTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:WaterUseTypeName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:ConsumptiveIndicator"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:FreshSalineIndicator"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:SourceTypeName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
				<td><xsl:value-of select="format-number(WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber, '#,###','num')"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
				<td><xsl:value-of select="format-number(WC:WaterUseAmountSummary/WC:PopulationServedNumber, '#.###','num')"/></td>
				<td><xsl:value-of select="format-number(WC:WaterUseAmountSummary/WC:PowerGeneratedNumber, '#.###','num')"/></td>
				<td><xsl:value-of select="format-number(WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:AmountNumber, '#,###.##','num')"/></td>				
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:TimeFrame/WC:TimeFrameStartName"/></td>
				<td><xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:TimeFrame/WC:TimeFrameEndName"/></td>	
				<!--Test for use WFS. If yes, add use GIS hyperlink. If no, omit hyperlink-->
				<td><xsl:choose>
					<xsl:when test="../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='USE'">
					<a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
					<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:attribute>
					<xsl:attribute name="TARGET">
					<xsl:text disable-output-escaping="yes">
					_blank</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:otherwise>
				</xsl:choose></td>
				<td><a><xsl:attribute name="href">
				<xsl:value-of select="../../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:WaterUseAmountSummary/WC:WaterUseAmount/WC:Method/WC:MethodName"/></a></td>
				</tr>
				</xsl:for-each>
				</table>
				</td>
				</tr>
				</table></div>
			<div class="header">
			<ul class="nav nav-pills pull-right">
			</ul></div>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:DerivedWaterSupplySummary">	
  		<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo2">		
			<p><b><u><h4>Estimated Water Supply Summary</h4></u></b></p></button>
	   		<div id="demo2" class="collapse">
			<table>
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>WaterSupply<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table style="width:800px">
     			<tr>
			<th>Supply Type</th>
       		<th>Acre-Feet Per Year (AFY)</th>
			<th>GIS Feature</th>
       		<th>Water Supply Methodology</th>
       			</tr>
       			<xsl:for-each select="WC:DerivedWaterSupplySummary/WC:DerivedWaterSupplyType">
			<xsl:sort select="WC:WaterSupplyTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:WaterSupplyTypeName"/></td>
				<td><xsl:value-of select="format-number(WC:SupplyAmountSummary/WC:AmountNumber, '#,###.##','num')"/></td>
				<!--Test for supply WFS. If yes, add supply GIS hyperlink. If no, omit hyperlink-->
				<td><xsl:choose>
					<xsl:when test="../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='SUPPLY'">
					<a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
					<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:attribute>
					<xsl:attribute name="TARGET">
					<xsl:text disable-output-escaping="yes">
					_blank</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:otherwise>
				</xsl:choose></td>
				<td><a><xsl:attribute name="href">
				<xsl:value-of select="../../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="WC:SupplyAmountSummary/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="WC:SupplyAmountSummary/WC:Method/WC:MethodName"/></a></td>
				</tr>
			</xsl:for-each>
			</table>
			</td>
			</tr>
			</table></div>
		<div class="header">
		<ul class="nav nav-pills pull-right">
		</ul></div>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:AllocationSummary">	
   		<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo3">		
			<p><b><u><h4>Water Allocation Summary(Water Rights/Permits)</h4></u></b></p></button>
		   	<div id="demo3" class="collapse">	
			<table>
			<tr>
			<td>
			<div><xsl:attribute name="id"><xsl:value-of select="../WC:ReportIdentifier"/>Allocation<xsl:value-of select="WC:ReportingUnitIdentifier"/></xsl:attribute></div>
			</td>
			<td>
			<table style="width:1200px">
     			<tr>
			<th>Allocation Beneficial Use</th>
       			<th>Fresh/Saline</th>
       			<th>Source Type</th>
       			<th>Irrigation?</th>
       			<th>Irrigated Acres</th>
       			<th>Crop Type</th>
       			<th>Acre-Feet Per Year (AFY)</th>
       			<th>GIS Feature</th>
			</tr>
			<xsl:for-each select="WC:AllocationSummary/WC:AllocationUse">
			<xsl:sort select="WC:AllocationUseTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:AllocationUseTypeName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:FreshSalineIndicator"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:SourceTypeName"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
				<td><xsl:value-of select="format-number(WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber, '#,###','num')"/></td>
				<td><xsl:value-of select="WC:AllocationAmountSummary/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
				<td><xsl:value-of select="format-number(WC:AllocationAmountSummary/WC:AmountNumber, '#,###.##','num')"/></td>				
				<!--Test for allocation WFS. If yes, add allocation GIS hyperlink. If no, omit hyperlink-->				
				<td><xsl:choose>
					<xsl:when test="../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='ALLOCATION'">
					<a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
					<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:attribute>
					<xsl:attribute name="TARGET">
					<xsl:text disable-output-escaping="yes">
					_blank</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:otherwise>
				</xsl:choose></td>
				</tr>
				</xsl:for-each>
				</table>
				</td>
				</tr>
				</table></div>
				<div class="header">
				<ul class="nav nav-pills pull-right">
				</ul></div>
		</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="WC:RegulatorySummary">	
  			<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo4">		
			<p><b><u><h4>Regulatory/Institutional Summary</h4></u></b></p></button>
			<div id="demo4" class="collapse">
			<table style="width:1200px">
     			<tr>
			<th>Regulatory Type</th>
       		<th>Regulatory Status</th>
			<th>Oversight Agency</th>
			<th>GIS Feature</th>
       			<th>Regulatory Description</th>
       			</tr>
       			<xsl:for-each select="WC:RegulatorySummary/WC:RegulatoryType">
			<xsl:sort select="WC:RegulatoryTypeName"/>
				<tr>
				<td><xsl:value-of select="WC:RegulatoryTypeName"/></td>
				<td><xsl:value-of select="WC:RegulatoryStatusText"/></td>
				<td><xsl:value-of select="WC:OversightAgencyName"/></td>
				<!--Test for regulatory WFS. If yes, add regulatory GIS hyperlink. If no, omit hyperlink-->				
				<td><xsl:choose>
					<xsl:when test="../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='REGULATORY'">
					<a><xsl:attribute name="href">
					<xsl:value-of select="../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
					<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:attribute>
					<xsl:attribute name="TARGET">
					<xsl:text disable-output-escaping="yes">
					_blank</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:otherwise>
				</xsl:choose></td>
				<td><xsl:value-of select="WC:RegulatoryDescriptionText"/></td>
				</tr>
			</xsl:for-each>
			</table></div>
		</xsl:when>
	</xsl:choose>

</xsl:for-each>
</xsl:template> 
</xsl:stylesheet> 

