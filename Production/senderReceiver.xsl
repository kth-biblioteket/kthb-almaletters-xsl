<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="senderReceiver">
<table cellspacing="0" cellpadding="5" border="0" width="100%" style="padding-top: 20px;">
	<tr>
		<td width="50%">
			<xsl:for-each select="notification_data/organization_unit">
				<table>
					<xsl:attribute name="style">
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<!--Kommenterat bort "name" då vi har lagt biblioteksnamnet i address/line1 -->
					<!--tr><td><xsl:value-of select="name"/></td></tr-->
					<tr><td><xsl:value-of select="address/line1"/></td></tr>
					<tr><td><xsl:value-of select="address/line2"/></td></tr>
					<tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
					<!--tr><td><xsl:value-of select="address/country"/></td></tr-->
				</table>
			</xsl:for-each>
		</td>
		<td width="50%" align="right">
			<xsl:choose>
				<xsl:when test="notification_data/user_for_printing">
					<table>
						<xsl:attribute name="style">
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<!-- Bibliotek som user saknar ofta för- eller efternamn. Lägg till villkor så att de skrivs ut-->
						<xsl:choose>
							<xsl:when test="contains(notification_data/user_for_printing/name, ',')">
								<!-- Alma skapar user_for_printing/name enligt: "Efternamn, Förnamn". Gör om det till "Förnamn Efternamn" samt Bold -->
								<tr><td><b><xsl:value-of select="substring-after(notification_data/user_for_printing/name, ', ') "/>&#160;<xsl:value-of select="substring-before(notification_data/user_for_printing/name, ',') "/></b></td></tr>
							</xsl:when>
							<xsl:otherwise>
								<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
							</xsl:otherwise>
						</xsl:choose>	
						<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>&#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
						<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country"/></td></tr>
						<!-- Se till att låntagarens Barcode skrivs ut på Lost Item-->
						<xsl:choose>
							<xsl:when test="notification_data/general_data/letter_type='FulLostLoanLetter' or notification_data/general_data/letter_type='FulOverdueAndLostLoanLetter'">
								<xsl:for-each select="notification_data/user_for_printing/identifiers/code_value">
									<xsl:if test="code='BARCODE'">
										<tr>
											<td>
												<table>
													<tr>
														<td style="text-align: center;padding:0px;">
															<!--mso-hide:all för att dölja i outlook-->
															<span style="visibility: hidden;mso-hide:all" class="patronbarcode">*<xsl:value-of select="value"/>*</span>
															<span style="visibility: hidden;mso-hide:all" class="patronbarcodenumbers"><xsl:value-of select="value"/></span>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:if>
								</xsl:for-each>
							</xsl:when>
						</xsl:choose>
					</table>
				</xsl:when>
				<xsl:when test="notification_data/receivers/receiver/user">
					<xsl:for-each select="notification_data/receivers/receiver/user">
						<table>
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
							</xsl:attribute>
							<tr><td><b><xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/></b></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/></td></tr>
							<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country"/></td></tr>
						</table>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</table>
</xsl:template>
</xsl:stylesheet>