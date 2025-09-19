<?xml version="1.0" encoding="utf-8"?>

<!--
Форма: sys.xsl
Наименование: файл системных данных (наборы атрибутов)

$Revision: 1.1 $
$Date: 2009/01/12 08:59:05 $
-->


<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xsl"
	version="1.0">

<xsl:template mode="_str_concat" match="@*|*">
	<xsl:param name="name"/>

	<xsl:if test="string-length(normalize-space(.)) > 0">
			<xsl:value-of select="concat($name, ' ', normalize-space(.), ' ')"/>
	</xsl:if>
</xsl:template>

<xsl:template name="_str_concat2">
	<xsl:param name="name"/>
	<xsl:param name="value"/>

	<xsl:if test="string-length(normalize-space($value)) > 0">
			<xsl:value-of select="concat($name, ' ', $value, ' ')"/>
	</xsl:if>
</xsl:template>

<xsl:template mode="date" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:call-template name="_date">
			<xsl:with-param name="datestr" select="."/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template mode="sqldate" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:call-template name="_sqldate">
			<xsl:with-param name="datestr" select="."/>
		</xsl:call-template>
		
		<xsl:if test="substring-after(.,'T') != '00:00:00'">
			&#160;<xsl:value-of select="substring(., 12, 5)"/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template mode="sqldate-date" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:call-template name="_sqldate">
			<xsl:with-param name="datestr" select="."/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template mode="dsigdate" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:call-template name="_sqldate">
			<xsl:with-param name="datestr" select="."/>
		</xsl:call-template>
		
		<xsl:if test="substring-after(.,'T') != '00:00:00'">
			&#160;<xsl:value-of select="substring(., 12, 8)"/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template mode="time" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:variable name="_timeval" select="concat(substring(., 10, 2), ':', substring(., 12, 2))"/>

		<xsl:if test="not(starts-with($_timeval, ':'))">
				<xsl:value-of select="$_timeval"/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template mode="date_time" match="@*|*">
	<xsl:if test="string-length(normalize-space(.)) > 0">
		<xsl:call-template name="_date_time">
			<xsl:with-param name="datestr" select="."/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="_date">
	<xsl:param name="datestr"/>

	<xsl:if test="string-length(normalize-space($datestr)) > 0">
		<xsl:value-of
			select="concat(	substring($datestr, 7, 2), '.',
									substring($datestr, 5, 2), '.',
									substring($datestr, 1, 4) )" />
	</xsl:if>
</xsl:template>

<xsl:template name="_sqldate">
	<xsl:param name="datestr"/>

	<xsl:if test="string-length(normalize-space($datestr)) > 0">
		<xsl:value-of
			select="concat(	substring($datestr, 9, 2), '.',
									substring($datestr, 6, 2), '.',
									substring($datestr, 1, 4) )" />
	</xsl:if>
</xsl:template>

<xsl:template name="_date_time">
	<xsl:param name="datestr"/>

	<xsl:variable name="_dateval">
			<xsl:call-template name="_date">
				<xsl:with-param name="datestr" select="$datestr"/>
			</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="_timeval" select="concat(substring($datestr, 10, 2), ':', substring($datestr, 12, 2), ':00')"/>

	<xsl:choose>
		<xsl:when test="starts-with($_timeval, ':')">
			<xsl:value-of select="$_dateval" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($_dateval, 'T', $_timeval)"/>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>


</xsl:stylesheet>