<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
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
			<br />
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							@@additional_info_1@@
							<br />
							<br />
							<!-- Skriv ut text beroende på typ av påminnelse (1, 2 eller 3) -->
							<xsl:if test="/notification_data/notification_type='OverdueNotificationType1'">
								@@inform_you_item_below_type1@@
							</xsl:if>
							<xsl:if test="/notification_data/notification_type='OverdueNotificationType2'">
								@@inform_you_item_below_type2@@
							</xsl:if>
							<xsl:if test="/notification_data/notification_type='OverdueNotificationType3'">
								@@inform_you_item_below_type3@@ 
								<br />
								<br />
								<em>@@additional_info_1_type3@@</em>
								<br />
								<br />
								@@additional_info_2_type3@@
							</xsl:if>					
						</td>
					</tr>
				</table>
				<table cellpadding="5" class="listing">
					<xsl:attribute name="style">
						<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
						<tr>
							<td>
								<table cellpadding="5" class="listing">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss" />
									</xsl:attribute>
									<!--<tr align="center" bgcolor="#f5f5f5">
										<td colspan="8">
											<h3><xsl:value-of select="organization_unit/name" /></h3>
										</td>
									</tr>-->	
									<tr>
										<th>@@lost_item@@</th>
										<th>@@library@@</th>
										<th>@@loan_date@@</th>
										<th>@@due_date@@</th>
										<th>@@barcode@@</th>
										<th>@@call_number@@</th>
									</tr>
									<xsl:for-each select="notification_data/loans_by_library/library_loans_for_display">
									<xsl:for-each select="item_loans/overdue_and_lost_loan_notification_display">
										<tr>
											<td><xsl:value-of select="item_loan/title"/></td>
											<td><xsl:value-of select="physical_item_display_for_printing/library_name"/></td>
											<td><xsl:value-of select="item_loan/loan_date"/></td>
											<td><xsl:value-of select="item_loan/due_date"/></td>
											<td><xsl:value-of select="item_loan/barcode"/></td>
											<td><xsl:value-of select="physical_item_display_for_printing/call_number"/></td>
										</tr>
									</xsl:for-each>
									</xsl:for-each>
								</table>
							</td>
						</tr>
						<hr/>
					<table style="padding-top:30px">
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>
					</table>
				</table>
				<br />
				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>