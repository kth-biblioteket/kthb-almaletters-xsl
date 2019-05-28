<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="salutation">
	</xsl:template>
	<xsl:template name="lastFooter">
		<table>
			<xsl:attribute name="style">
				<xsl:call-template name="footerTableStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<tr>
				<xsl:for-each select="notification_data/organization_unit">
					<xsl:attribute name="style">
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<!-- Visa endast organisationsnamnet här-->
					<td align="center">
						<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language='sv'">
							KTH Biblioteket
						</xsl:if>
						<xsl:if test="/notification_data/receivers/receiver/user/user_preferred_language='en'">
							KTH Library
						</xsl:if>
					</td>
					<!--td align="center">
						<xsl:value-of select="name"/>&#160;<xsl:value-of select="line1"/>&#160;<xsl:value-of select="line2"/>&#160;<xsl:value-of select="city"/>&#160;<xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="country"/>
					</td-->
				</xsl:for-each>
			</tr>
		</table>
		<table>
			<tr>
				<td>
					<xsl:if test="notification_data/receivers/receiver/user/user_preferred_language='sv'">
						Observera att du inte kan svara på detta mail.
					</xsl:if>
					<xsl:if test="notification_data/receivers/receiver/user/user_preferred_language='en'">
						Please note that you can not reply to this email.
					</xsl:if>
				</td>
			</tr>
		</table>
		<table align="left">
			<tr>
				<td align="left">
					<a><xsl:attribute name="href">@@email_contact_us@@</xsl:attribute>@@contact_us@@</a>
				</td>
			</tr>
		</table>
		<table align="right">
			<tr>
				<td align="right">
					<a><xsl:attribute name="href">@@email_my_account@@</xsl:attribute>@@my_account@@</a>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="contactUs">
	</xsl:template>
	<xsl:template name="lastFooterKvitto">
		<table>
			<xsl:attribute name="style">
				<xsl:call-template name="footerKvittoTableStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<tr>
			<xsl:for-each select="notification_data/organization_unit">
				<xsl:attribute name="style">
					<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
					<!--td align="center"><xsl:value-of select="name"/>&#160;<xsl:value-of select="line1"/>&#160;<xsl:value-of select="line2"/>&#160;<xsl:value-of select="city"/>&#160;<xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="country"/></td-->
			</xsl:for-each>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>