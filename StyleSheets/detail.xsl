<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:WC="http://www.exchangenetwork.net/schema/WaDE/0.2">
<xsl:decimal-format name="num" decimal-separator="." grouping-separator=","/>
<xsl:template match="WC:WaDE">
<html>
   	<head>
   		<meta name="description" content="WSWS - Details" />
		<title>WSWC - Detailed (Site-specific) Data</title>
		<link rel="stylesheet" href="../styles/vendor.css" />
		<link rel="stylesheet" href="../styles/main.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
		<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>		
   	</head>
   	

   	
   	<body>
        
   	<div class="container">
	   <div class="header">
		<ul class="nav nav-pills pull-right">
			<li class=" ">
		<!--TODO: Add link back to map interface.-->
			<a target="_self" title="Home" href="http://wswc.maps.arcgis.com/apps/MapJournal/index.html?appid=0559c438673a4c42bb29d91aaaa1cb9a">Back to Map</a>
			</li>
			<li class=" active ">
			<a target="_self" title="About" href="http://www.westernstateswater.org/wade">About</a>
			</li>
		</ul>
		<a href="http://www.westernstateswater.org" title="WSWC Home">
		<img src="../images/wswclogo.png" alt="WSWC logo" height="60"/>
		</a>
		<h1>Western States Water Council - Water Data Exchange (WaDE) Detailed Data</h1>
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
	<p><h4><u>Location Information</u></h4></p>
	<p>State: <xsl:value-of select="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:StateCode"/></p> 
<xsl:if test="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationType='REPORTUNIT'">
	<p>Reporting Unit: <xsl:value-of select="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationText"/></p>
</xsl:if>
<xsl:if test="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationType='COUNTY'">
	<p>County: <xsl:value-of select="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationText"/></p>
</xsl:if>
<xsl:if test="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationType='HUC'">	
	<p>Hydrologic Unit Code (HUC): <xsl:value-of select="WC:Report/WC:ReportDetails/WC:WaterAllocation/WC:DetailLocation/WC:PrimaryLocationText"/></p>
</xsl:if>

<xsl:apply-templates select="WC:Report"/>
</xsl:template> 

<xsl:template match="WC:Report">

<!--TODO: Ensure that each WFS shared by your organization is publically available,
i.e. a user does not need to log in to a website/provide credentials to access a map
or the JSON, geoJSON, etc. -->

<!--Test for WFS-->
<xsl:if test="WC:GeospatialReference/WC:WFSType/WC:WFSDataCategory='DETAIL'">
  	<p><h4>Related Web Feature Service(s) (WFS):</h4>
  	<table border="1">
  		<tr>
   	<th>WFS Type</th>
   	<th>WFS Link</th>
   	<th>Unique ID Column</th>
      </tr>
      <xsl:for-each select="WC:GeospatialReference/WC:WFSType">
   	  <tr>
   		<td><xsl:value-of select="WC:WFSTypeName"/></td>
   		<td><a><xsl:attribute name="href">
   			<xsl:value-of select="WC:WFSAddressLink"/>
			</xsl:attribute>
			<xsl:attribute name="TARGET">
			<xsl:text disable-output-escaping="yes">
			_blank</xsl:text>
			</xsl:attribute>Click Here for WFS</a></td>
   		<td><xsl:value-of select="WC:WFSFeatureIDFieldText"/></td>
  	   </tr>
      </xsl:for-each>
  </table></p>
</xsl:if>

   <p>This information is relevant for the reporting year: <xsl:value-of select="WC:ReportingYear"/></p>
   <p>These data were reported on: <xsl:value-of select="WC:ReportingDate"/></p>
   <p><h6>*Note: Allocation/diversion data may be extensive and tables may be expansive. 
   Scroll to the bottom of the page for all data retrieved.</h6></p>
   	<xsl:choose>   
   		<xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:AllocationAmount">
   		<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo">	
   		<p><b><u><h4>Water Allocations (Total Amount for Water Right/Permit)</h4></u></b></p></button>
   		<div id="demo" class="collapse">
   		<div class="row">
   			<div class="col-md-10">
   				<div class="callout-note callout ng-isolate-scope" closeable="true">
   		<p>
                *Water may be allocated using a volume, a flowrate, or 
                both (flowrate with volume as a maximum diversion).</p>
                <p>**The total amount of water actually diverted from 
                all diversions associated with this allocation
   		OR the total amount of water that flowed for the allocation if no 
   		diversion was made, for example, an instream flow amount.</p>
   		</div>
   	</div>
        </div>   
   		<p><table border="1">
     		<tr>
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
       		<th>GIS Feature</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Fresh/Saline</th>
       		<th>Total Volume for Allocation*</th>
       		<th>Units</th>
       		<th>Total Rate for Allocation</th>
       		<th>Units</th>
       		<th>Allocation Start Date</th>
       		<th>Allocation End Date</th>
       		<th>Source Name</th>
       		<th>Actual Volume Diverted/Flowed**</th>
       		<th>Units</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
       		<th>Actual Rate Diverted/Flowed**</th>
       		<th>Units</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
       		<th>Actual Start Date</th>
       		<th>Actual End Date</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:AllocationAmount/WC:WaterAllocated/WC:BeneficialUse/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../../WC:LegalStatusCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<!--Test for allocation WFS. If yes, add Water Right GIS hyperlink. If no, omit hyperlink. -->
			<td><xsl:choose>
				<xsl:when test="../../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='ALLOCATION'">
				<a><xsl:attribute name="href">
					<xsl:value-of select="../../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
					<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
					<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
					</xsl:attribute>
					<xsl:attribute name="TARGET">
					<xsl:text disable-output-escaping="yes">
					_blank</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:otherwise>
			</xsl:choose></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../../WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../../WC:SourceName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href"/>
			<xsl:value-of select="../../../../../../../WC:WaDEURLAddress"/>	
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/></a></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../../../WC:WaDEURLAddress"/>	
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:Method/WC:MethodName"/></a></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:TimeFrame/WC:TimeFrameEndName"/></td>			
		</tr>
		</xsl:for-each>
	</table></p></div>
	<div class="header">
	<ul class="nav nav-pills pull-right">
	</ul></div>
	</xsl:when>
	</xsl:choose>

<xsl:choose>
   <xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:Diversion">	
	<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo2">	   
	<p><b><u><h4>Water Allocations and Associated Diversions</h4></u></b></p></button>
   		<div id="demo2" class="collapse">	
   		<p><table border="1">
     		<tr>
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Diversion ID</th>
       		<th>Diversion Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
       		<th>GIS Feature</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Fresh/Saline</th>
       		<th>Allocated Volume for Diversion</th>
       		<th>Units</th>
       		<th>Allocated Rate for Diversion</th>
       		<th>Units</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Source Name</th>
       		<th>Actual Volume Diverted</th>
       		<th>Units</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
       		<th>Actual Rate Diverted</th>
       		<th>Units</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
     		</tr>
	<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:Diversion/WC:DiversionAmount/WC:WaterAllocated/WC:BeneficialUse/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../../../WC:LegalStatusCode"/></td>
			<td><xsl:value-of select="../../../../WC:DiversionIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DiversionName"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<!--Test for diversion WFS. If yes, add Diversion GIS hyperlink. If no, omit hyperlink. -->
			<td><xsl:choose>
				<xsl:when test="../../../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='DIVERSION'">
				<a><xsl:attribute name="href">
				<xsl:value-of select="../../../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
				<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
				<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:attribute>
				<xsl:attribute name="TARGET">
				<xsl:text disable-output-escaping="yes">
				_blank</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="../../../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:otherwise>
			</xsl:choose></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../../WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../../WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../../WC:AllocatedRate/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../../WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../../WC:SourceName"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../../../../WC:WaDEURLAddress"/>
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/></a></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountNumber"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualRate/WC:ActualAmountUnitsCode"/></td>
			<td><xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../../../../WC:WaDEURLAddress"/>			
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
			<xsl:value-of select="../../WC:ActualFlow/WC:ActualVolume/WC:Method/WC:MethodName"/></a></td>
		</tr>
	</xsl:for-each>
	</table></p></div>
	<div class="header">
	<ul class="nav nav-pills pull-right">
	</ul></div>
	</xsl:when>
</xsl:choose>
<xsl:choose>
	<xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:ConsumptiveUse">	
	<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo3">
	<p><b><u><h4>Water Allocations and Associated Consumptive Uses</h4></u></b></p></button>
	<div id="demo3" class="collapse">
		<p><table border="1">
     		<tr>
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Consumptive Use ID</th>
       		<th>Consumptive User Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
      		<th>GIS Feature</th>
       		<th>Beneficial Use</th>
       		<th>Source Type</th>
       		<th>Source Name</th>
       		<th>Fresh/Saline</th>
       		<th>Irrigation Method</th>
       		<th>Acres Irrigated</th>
       		<th>Crop Type</th>
       		<th>Energy Generation</th>
       		<th>Power Capacity</th>
       		<th>Volume of Use</th>
       		<th>Units</th>
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Estimated Source</th>
       		<th>Method</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:ConsumptiveUse/WC:UseEstimate/WC:BeneficialUseTypeName">
		<xsl:sort select="../../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../../WC:LegalStatusCode"/></td>			
			<td><xsl:value-of select="../../WC:UserIdentifier"/></td>
			<td><xsl:value-of select="../../WC:UserName"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<!--Test for use WFS. If yes, add Use GIS hyperlink. If no, omit hyperlink. -->
			<td><xsl:choose>
				<xsl:when test="../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='USE'">
				<a><xsl:attribute name="href">
				<xsl:value-of select="../../../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
				<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
				<xsl:value-of select="../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:attribute>
				<xsl:attribute name="TARGET">
				<xsl:text disable-output-escaping="yes">
				_blank</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="../../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:otherwise>
			</xsl:choose></td>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:SourceTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:SourceName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:FreshSalineIndicator"/></td>			
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:IrrigationMethodName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:AcresIrrigatedNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:IrrigationWaterSupply/WC:CropTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:ThermoElectricWaterSupply/WC:GeneratorTypeName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:ThermoElectricWaterSupply/WC:PowerCapacityNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:AmountUnitsCode"/></td>		
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:ValueTypeCode"/></td>			
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../../WC:WaDEURLAddress"/>			
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../WC:UseAmount/WC:UseVolume/WC:Method/WC:MethodName"/></a></td>
		</tr>
	</xsl:for-each>
	</table></p></div>
	<div class="header">
	<ul class="nav nav-pills pull-right">
	</ul></div>
	</xsl:when>
</xsl:choose>
<xsl:choose>
	<xsl:when test="WC:ReportDetails/WC:WaterAllocation/WC:ReturnFlow">	
	<button type="button" class="btn btn-info collapsed" data-toggle="collapse" data-target="#demo4">	
		<p><b><u><h4>Water Allocations and Associated Return Flows</h4></u></b></p></button>
		<div id="demo4" class="collapse">
		<p><table border="1">
     		<tr>
       		<th>Allocation ID</th>
       		<th>Allocation Owner</th>
       		<th>Priority Date</th>
       		<th>Legal Status</th>
       		<th>Return Flow ID</th>
       		<th>Return Flow Name</th>
       		<th>Reporting Unit</th>
		<th>County</th>
       		<th>HUC</th>
      		<th>GIS Feature</th>
       		<th>Volume of Return Flow</th>
       		<th>Units</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
       		<th>Rate of Return Flow</th>
       		<th>Units</th>       		
       		<th>Start Date</th>
       		<th>End Date</th>
       		<th>Estimate Source</th>
       		<th>Method</th>
     		</tr>
     		<xsl:for-each select="WC:ReportDetails/WC:WaterAllocation/WC:ReturnFlow/WC:ReturnFlowName">
		<xsl:sort select="../../WC:AllocationIdentifier"/>
		<tr>
       			<td><xsl:value-of select="../../WC:AllocationIdentifier"/></td>
			<td><xsl:value-of select="../../WC:AllocationOwnerName"/></td>
			<td><xsl:value-of select="../../WC:PriorityDate"/></td>
			<td><xsl:value-of select="../../WC:LegalStatusCode"/></td>			
			<td><xsl:value-of select="../WC:ReturnFlowIdentifier"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowName"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:ReportingUnitIdentifier"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:CountyFipsCode"/></td>
			<td><xsl:value-of select="../WC:DetailLocation/WC:HydrologicUnitCode"/></td>
			<td><xsl:choose>
				<xsl:when test ="../../../../WC:GeospatialReference/WC:WFSType/WC:WFSTypeName='RETURN'">
				<a><xsl:attribute name="href">
				<xsl:value-of select="../../../../WC:GeospatialReference/WC:WFSType/WC:WFSAddressLink"/>
				<xsl:text disable-output-escaping="yes">&amp;find=</xsl:text>
				<xsl:value-of select="../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:attribute>
				<xsl:attribute name="TARGET">
				<xsl:text disable-output-escaping="yes">
				_blank</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/></a>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="../WC:DetailLocation/WC:WFSReference/WC:WFSFeatureIdentifier"/>
				</xsl:otherwise>
			</xsl:choose></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:AmountUnitsCode"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:ValueTypeCode"/></td>
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../WC:WaDEURLAddress"/>			
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnVolume/WC:Method/WC:MethodName"/></a></td>			
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:AmountNumber"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:AmountUnitsCode"/></td>		
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:TimeFrame/WC:TimeFrameStartName"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:TimeFrame/WC:TimeFrameEndName"/></td>
			<td><xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:ValueTypeCode"/></td>
			<td><a><xsl:attribute name="href">
	            	<xsl:value-of select="../../../../../WC:WaDEURLAddress"/>			
						<xsl:text disable-output-escaping="yes">/WADE/v0.2/GetMethod/GetMethod.php?methodid=</xsl:text>
						<xsl:value-of select="../../../../../WC:OrganizationIdentifier"/>
						<xsl:text disable-output-escaping="yes">&amp;methodname=</xsl:text>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:Method/WC:MethodName"/>
						</xsl:attribute>
						<xsl:attribute name="TARGET">
						<xsl:text disable-output-escaping="yes">
						_blank</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="../WC:ReturnFlowAmount/WC:ReturnRate/WC:Method/WC:MethodName"/></a></td>	
		</tr>
		</xsl:for-each>
		</table></p></div>
	</xsl:when>
</xsl:choose>
</xsl:template> 
</xsl:stylesheet> 

