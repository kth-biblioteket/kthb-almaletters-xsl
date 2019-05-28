<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Start default template -->
	<xsl:template name="head">
		<table cellspacing="0" cellpadding="5" border="0">
			<xsl:attribute name="style">
				<xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<!-- LOGO INSERT -->
			<tr>
				<xsl:attribute name="style">
					<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="notification_data/general_data/letter_type='aFulTransitSlipLetter'">
					</xsl:when>
					<xsl:when test="notification_data/general_data/letter_type='aFulReasourceRequestSlipLetter'">
					</xsl:when>
					<xsl:otherwise>
						<td colspan="1">
							<div id="mailHeader">
								<div id="logoContainer" class="alignLeft">
									<img src="cid:logo.jpg" alt="logo"/>
								</div>
							</div>
						</td>
					</xsl:otherwise>
				</xsl:choose>
			<!--/tr-->
			<!-- END OF LOGO INSERT -->
			<!--tr-->
				<xsl:for-each select="notification_data/general_data">
					<td>
						<xsl:choose>
							<xsl:when test="letter_type='FulLostLoanNotificationLetter' or letter_type='FulOverdueAndLostLoanNotificationLetter'">
								<xsl:choose>
									<xsl:when test="/notification_data/notification_type='OverdueNotificationType1'">
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language='sv'">
											<h1>Påminnelse om återlämning 1</h1>
										</xsl:if>
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language!='sv'">
											<h1>Overdue Reminder 1</h1>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/notification_data/notification_type='OverdueNotificationType2'">
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language='sv'">
											<h1>Påminnelse om återlämning 2</h1>
										</xsl:if>
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language!='sv'">
											<h1>Overdue Reminder 2</h1>
										</xsl:if>
									</xsl:when>
									<xsl:when test="/notification_data/notification_type='OverdueNotificationType3'">
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language='sv'">
											<h1>Sista påminnelsen!</h1>
										</xsl:if>
										<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language!='sv'">
											<h1>Last reminder!</h1>
										</xsl:if>
									</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="letter_type='FulTransitSlipLetter'">
								<h1><xsl:value-of select="subject"/></h1>
							</xsl:when>
							<xsl:otherwise>
								<h1><xsl:value-of select="letter_name"/></h1>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td align="right">
						<xsl:value-of select="current_date"/>
					</td>
				</xsl:for-each>
			</tr>
		</table>
	</xsl:template> 
	<!-- Slut på default template -->
	<!-- Start Template for slippar(requests/transit)  -->
	<xsl:template name="headkvitto"> <!--headkvitto-->
		<table cellspacing="0" cellpadding="5" border="0">
			<xsl:attribute name="style">
				<xsl:call-template name="headerKvittoTableStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
		<!-- LOGO INSERT -->
			<tr>
				<xsl:attribute name="style">
					<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
				<td colspan="1">
					<div id="mailHeader">
						<div id="logoContainer" class="alignLeft">
							<img src="cid:logo.jpg" alt="logo"/>
						</div>
					</div>
				</td>
		<!-- END OF LOGO INSERT -->
				<xsl:for-each select="notification_data/general_data">
					<xsl:choose>
						<xsl:when test="letter_name='Resource Request Slip Letter'">
						</xsl:when>
						<xsl:otherwise>
							<h1><xsl:value-of select="subject"/></h1>
							<td align="left">
								<xsl:value-of select="current_date"/>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</tr>
		</table>
	</xsl:template> 
	<!-- Slut på kvitto template -->
</xsl:stylesheet>