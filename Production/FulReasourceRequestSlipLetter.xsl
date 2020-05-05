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
				<xsl:call-template name="generalStyle" /> <!-- style.xsl -->
			</head>
			<body>
				<!--xsl:call-template name="headkvitto" /--> <!-- header.xsl --> <!-- Skriv inte ut någon header -->
				<div class="messageArea">
					<div class="messageBody">
						<xsl:if test="notification_data/user_for_printing/name">
							<table cellspacing="0" cellpadding="0" border="0">
								<tr>
									<td style="width:70px; padding-right: 5px;">
										<img style="width:100%" src="cid:logo.jpg" alt="logo"/>
									</td>
									<td>
										<table cellspacing="0" cellpadding="0" border="0" style="height: 70px">
											<tr>
												<!-- 20190424 Ny rubrik som bygger på vilken item policy eller location code som finns i XML -->
												<xsl:choose>
													<xsl:when test="notification_data/phys_item_display/available_items/available_item/item_policy='reading_room'">
														<td style="font-size: 24px;font-weight: bold">
															Reading room loan
														</td>
													</xsl:when>
													<xsl:when test="notification_data/phys_item_display/location_code='OUT_RS_REQ'">
														<td style="font-size: 24px;font-weight: bold">
															Resource sharing loan
														</td>
													</xsl:when>
													<xsl:otherwise>
														<td style="border: 2px solid black;padding: 3px; font-size: 24px;font-weight: bold">
															Please remember to borrow the book
														</td>
													</xsl:otherwise>
												</xsl:choose>
											</tr>
											<tr>
												<td style="line-height: 30px;vertical-align: bottom;font-size: 30px;font-weight: bold">
													<!-- 20190528 Bortkommenterat rubrik Requested for -->
													<!--div style="font-size: 16px;font-weight: bold">@@requested_for@@: </div-->
													<!-- 2020-04-28, Visa alltid namnet tillfälligt nu när bibblan är stängd -->
													<xsl:value-of select="notification_data/user_for_printing/name"/>
													<!--xsl:choose>
														<xsl:when test="notification_data/phys_item_display/location_code='OUT_RS_REQ' or notification_data/phys_item_display/available_items/available_item/item_policy='reading_room'">
															<xsl:value-of select="notification_data/user_for_printing/name"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="notification_data/additional_id"/>
														</xsl:otherwise>
													</xsl:choose-->
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</xsl:if>
						<br/>
						<table cellspacing="0" cellpadding="5" border="0">
								<tr>
									<td>
									<xsl:if test="notification_data/request/work_flow_entity/step_type!='ON_HOLD_SHELF'">
										<b>Printed: </b><xsl:value-of select="notification_data/general_data/current_date"/>
									</xsl:if>
									<xsl:if test="notification_data/request/work_flow_entity/step_type='ON_HOLD_SHELF'">
										<b>Printed: </b><xsl:value-of select="notification_data/general_data/current_date"/>&#160;<b>Held until: </b><xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>
									</xsl:if>
									</td>
								</tr>
							<xsl:if test="notification_data/request/note != ''">
								<!-- 20190528 Villkor för att request note ej ska visas för fjärrlån -->
								<xsl:if test="notification_data/phys_item_display/location_code !='OUT_RS_REQ'">
									<tr>
										<td style="border: 2px solid #000000;">
											<b>@@request_note@@: </b> <xsl:value-of select="notification_data/request/note"/>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
								<tr>
									<td><b>@@note_item_specified_request@@.</b></td>
								</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/manual_description != ''" >
								<tr>
									<td><b>@@please_note@@: </b>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
								</tr>
							</xsl:if>
							<tr>
								<td><b>@@request_id@@: </b><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
							</tr>
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'">
								<tr>
									<td><b>@@item_barcode@@: </b><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
								</tr>
							</xsl:if>
							<xsl:if  test="notification_data/external_id != ''" >
								<tr>
									<td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<b>Item:</b>
								</td>
							</tr>
							<tr>
								<td style="padding-left: 20px;">Title: <xsl:value-of select="notification_data/phys_item_display/title_abcnph"/>
								</td>
							</tr>
							<xsl:if test="notification_data/phys_item_display/author !=''">
								<tr>
									<td style="padding-left: 20px;">Author: <xsl:value-of select="notification_data/phys_item_display/author"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/isbn != ''">
								<tr>
									<td style="padding-left: 20px;">@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/issn != ''">
								<tr>
									<td style="padding-left: 20px;">@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/edition != ''">
								<tr>
									<td style="padding-left: 20px;">@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
									<td style="padding-left: 20px;">@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<b>@@location@@: </b><xsl:value-of select="notification_data/phys_item_display/location_name"/>
								</td>
							</tr>
							<xsl:choose>
								<xsl:when test="notification_data/phys_item_display/display_alt_call_numbers/string" > <!-- Finns alternativt Call Number så ska det skrivas ut istället för ordinarie -->
									<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
										<tr>
											<td>
												<b>@@call_number@@: </b>
												<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
													<xsl:value-of select="."/>
													&#160;
												</xsl:for-each>
											</td>
										</tr>
									</xsl:if>
									<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
										<tr>
											<td>
												<b>@@call_number@@: </b>
												<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
													<xsl:value-of select="."/>
													&#160;
												</xsl:for-each>
											</td>
										</tr>
									</xsl:if>
									<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
										<tr>
											<td>
												<b>@@call_number@@: </b>
												<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
													<xsl:value-of select="."/>
													&#160;
												</xsl:for-each>
											</td>
										</tr>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="notification_data/phys_item_display/call_number != ''">
										<tr>
											<td>
												<b>@@call_number@@: </b><xsl:value-of select="notification_data/phys_item_display/call_number"/>
											</td>
										</tr>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:if test="notification_data/phys_item_display/issue_level_description !=''">
								<tr>
									<td>
										<b>Description: </b><xsl:value-of select="notification_data/phys_item_display/issue_level_description"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/accession_number != ''">
								<tr>
									<td>
										<h2><b>@@accession_number@@: </b><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2>
									</td>
								</tr>
							</xsl:if>
							<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
								<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
									<tr>
										<td><b>@@shelving_location_for_item@@: </b>
											<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
												<xsl:value-of select="."/>
												&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
								<tr>
									<td>
										<b>@@shelving_locations_for_holding@@: </b>
										<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
											<xsl:value-of select="."/>
											&#160;
										</xsl:for-each>
									</td>
								</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
								<tr>
									<td>
										<b>@@shelving_locations_for_holding@@: </b>
										<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
											<xsl:value-of select="."/>
											&#160;
										</xsl:for-each>
									</td>
								</tr>
								</xsl:if>
							</xsl:if>
							<b></b>
							<tr>
								<td>
									<b>@@move_to_library@@: </b><xsl:value-of select="notification_data/destination"/>
								</td>
							</tr>
							<tr>
								<td>
									<b>@@request_type@@: </b><xsl:value-of select="notification_data/request_type"/>
								</td>
							</tr>
							<xsl:if test="notification_data/request/system_notes != ''">
								<tr>
									<td>
										<b>@@system_notes@@:</b><xsl:value-of select="notification_data/request/system_notes"/>
									</td>
								</tr>
							</xsl:if>
						</table>
					</div>
				</div>
				<!--xsl:call-template name="lastFooterKvitto" /--> <!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>