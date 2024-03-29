<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->
				<!-- Se till att fjärrlånebibliotek inte får ett mejl-->
				<xsl:if test="notification_data/user_for_printing/user_group='150' or notification_data/user_for_printing/user_group='160' or notification_data/user_for_printing/user_group='165' or notification_data/user_for_printing/user_group='170'">
					<xsl:message terminate="yes">user group is ILL!</xsl:message>ILL!
				</xsl:if>
				<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>
							<xsl:choose>
								<!-- För HB-->
								<xsl:when test="notification_data/request/delivery_address='Huvudbiblioteket' or notification_data/request/delivery_address='Main Library'">
									<xsl:choose>
										<!-- För fjärrlån och läsesalslån --> 
										<xsl:when test="contains(notification_data/phys_item_display/available_items/available_item/item_policy, 'reading_room') or contains(notification_data/phys_item_display/location_code, 'OUT_RS_REQ') ">
											<xsl:if test="notification_data/request/delivery_address='Main Library'">
												Your item is now available for pick up at the KTH Main Library. <br/><br/>
												<div style="font-size: 24px;">Pick up from circulation desk.</div> 
											</xsl:if>
											<xsl:if test="notification_data/request/delivery_address='Huvudbiblioteket'">
												Din bok finns nu att hämta på KTH Huvudbiblioteket.<br/><br/>
												<div style="font-size: 24px;">Hämta vid lånedisken.</div>
											</xsl:if>
										</xsl:when>
										<!-- För övriga låntyper-->
										<xsl:otherwise>
											<xsl:if test="notification_data/request/delivery_address='Main Library'">
												Your item is now available for pick up at the KTH Main Library.<br/><br/>
												<div style="font-size: 24px;">Pick from hold shelf: </div>
											</xsl:if>
											<xsl:if test="notification_data/request/delivery_address='Huvudbiblioteket'">
												Din bok finns nu att hämta på KTH Huvudbiblioteket.<br/><br/>
												<div style="font-size: 24px;">Hämta på reservationshyllan:</div>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<!-- För filialerna-->
								<xsl:otherwise>
									<xsl:if test="notification_data/receivers/receiver/preferred_language='sv'">
										Din bok finns nu att hämta på KTH Biblioteket i <span><xsl:value-of select="notification_data/request/delivery_address"/></span>.<br/><br/>
										<div style="font-size: 24px;">Hämta vid lånedisken:</div>
									</xsl:if>
									<xsl:if test="notification_data/receivers/receiver/preferred_language='en'">
										Your item is now available for pick up at the KTH Library in <span><xsl:value-of select="notification_data/request/delivery_address"/></span>.<br/><br/>
										<div style="font-size: 24px;">Pick up from circulation desk:</div>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Löpnummer(Additional ID)-->
							<xsl:if test="(notification_data/phys_item_display/location_code!='OUT_RS_REQ' and notification_data/phys_item_display/available_items/available_item/item_policy!='reading_room')">
							<div style="font-size: 24px;">
								<!-- Skapa krypterat löpnummer via anrop till API-->
								<xsl:if test="notification_data/user_for_printing/identifiers/code_value/code = 'Primary Identifier'">
									<xsl:variable name="primaryid">
										<xsl:value-of select="substring-before(notification_data/user_for_printing/identifiers/code_value/value,'@')"/>
									</xsl:variable>
									<xsl:variable name="additionalid">
										<xsl:value-of select="/notification_data/additional_id"/>
									</xsl:variable>
									<xsl:variable name="holdshelfnumber" select="document(concat('https://lib.kth.se/holdshelfno/api/v1/', $primaryid, '/',$additionalid,'/?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'))">
									</xsl:variable>
									<xsl:value-of select="$holdshelfnumber/holdshelfnumber/userid_encrypted"/>
									<xsl:value-of select="'-'"/>
									<xsl:value-of select="$holdshelfnumber/holdshelfnumber/holdshelfnumber"/>
								</xsl:if>
								<!--xsl:value-of select="notification_data/additional_id"/-->
							</div>
							</xsl:if>
							</td>
						</tr>
						<tr>
							<td><xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl --></td>
						</tr>
						
						<xsl:if test="notification_data/request/work_flow_entity/expiration_date">
						<tr>
							<td>
							 @@following_item_requested_on@@ <xsl:value-of select="notification_data/request/create_date"/> @@note_item_held_until@@ <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
							 </td>
						</tr>
						</xsl:if>
						<xsl:if test="notification_data/request/system_notes !=''">
						<tr>
							<td>@@notes_affect_loan@@</td>
						</tr>

						<tr>
							<td><xsl:value-of select="notification_data/request/system_notes"/></td>
						</tr>

						</xsl:if>
					</table>
				</div>
				</div>
				<br />
				<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
				</table>
				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
	</html>
	</xsl:template>
</xsl:stylesheet>