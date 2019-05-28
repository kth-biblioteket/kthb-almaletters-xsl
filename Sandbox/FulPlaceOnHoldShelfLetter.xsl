<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
												<b>Your item is now available for pick up at the Main Library. Show the following number at the circulation desk:</b>
											</xsl:if>
											<xsl:if test="notification_data/request/delivery_address='Huvudbiblioteket'">
												<b>Ditt exemplar finns nu att hämta på Huvudbiblioteket. Ange följande löpnummer i lånedisken:</b>
											</xsl:if>
										</xsl:when>
										<!-- För övriga lån-->
										<xsl:otherwise>
											<xsl:if test="notification_data/request/delivery_address='Main Library'">
												<b>Your item is now available for pick up at the Main Library. Use the following number to find your material on the hold shelf:</b>
											</xsl:if>
											<xsl:if test="notification_data/request/delivery_address='Huvudbiblioteket'">
												<b>Ditt exemplar finns nu att hämta på Huvudbiblioteket. Använd följande löpnummer för att hitta materialet på reservationshyllan:</b>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<!-- För filialerna-->
								<xsl:otherwise>
									<xsl:if test="notification_data/receivers/receiver/preferred_language='sv'">
										<b>Ditt exemplar finns nu att hämta på biblioteket i <span><xsl:value-of select="notification_data/request/delivery_address"/></span>. Ange följande löpnummer i lånedisken:</b>
									</xsl:if>
									<xsl:if test="notification_data/receivers/receiver/preferred_language='en'">
										<b>Your item is now available for pick up at the library in <span><xsl:value-of select="notification_data/request/delivery_address"/></span>. Show the following number at the circulation desk:</b>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<!-- Löpnummer(Additional ID)-->
							<div style="font-size: 30px;">
								<xsl:value-of select="notification_data/additional_id"/>
							</div>
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
