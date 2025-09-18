<?xml version="1.0" encoding="windows-1251"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<!--
$Name:  $
$Revision: 1.2 $
$Date: 2009/01/21 15:22:37 $
-->
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:t="http://cabinet.frsd.ru/schema/ufml3/rel-1/"
	xmlns:uf="urn:frsd:ufml3-filter"
	xmlns:dsig="http://www.w3.org/2000/09/xmldsig#"
	xmlns:dse="http://cabinet.frsd.ru/schema/xmldsigext-frsd/rel-1/"
	exclude-result-prefixes="xsl t uf dsig dse"
	version="1.0">

<xsl:import href="./html-base.xsl"/>

<xsl:output method="html" encoding="windows-1251"/>


<xsl:key name="total_key" match="/t:envelope/t:f203/t:rpt-data/t:opr-info" use="@code"/>
<xsl:key name="currency_key" match="/t:envelope/t:f203/t:rpt-data/t:opr-info" use="substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4)"/>

<xsl:template name="orient">landscape</xsl:template>

<xsl:template match="t:f203" mode="body">
	<xsl:call-template name="�����_����"/>
	<xsl:call-template name="�_���������"/>
	<xsl:call-template name="�_����_���"/>

	<xsl:apply-templates select="t:rpt-data"/>

	<xsl:call-template name="�������_�������"/>

	<div class="footnote">
		<p class="fnblock"><span class="fn">*</span><span class="text">
		<xsl:for-each select="t:rpt-data/t:opr-info[count(. | key('total_key', @code)[1])=1]">
			<xsl:value-of select="@code"/> - <xsl:call-template name="oper-text"/>; 
		</xsl:for-each>
		</span></p>
	</div>
</xsl:template>

<xsl:template match="t:rpt-data">

	<table xsl:use-attribute-sets="form_table2" rules="cols" class="form_table2">
		<col width="5%"/>
		<col width="10%"/>
		<col width="10%"/>
		<col width="5%"/>
		<col width="10%"/>
		<col width="7%"/>
		<col width="10%"/>
		<col width="19%"/>
		<col width="19%"/>
		<thead>
			<tr>
				<th>��� ��������</th>
				<th>� �������� �����</th>
				<th>���-�� ����</th>
				<th>���� ���, ����</th>
				<th>����� �����</th>
				<th>�������� / ������</th>
				<th>����� ��� �������� / ������</th>
				<th>��������� ��������</th>
				<th>�������� ����</th>
			</tr>
		</thead>

		<tbody>
			<xsl:apply-templates select="t:opr-info"/>
		</tbody>
	</table>

	<p style="margin-top: 12px;margin-left: 20px;"><b>�����</b></p>
	<table xsl:use-attribute-sets="form_table2" rules="cols" class="form_table2">
		<col width="5%"/>
		<col width="10%"/>
		<col width="10%"/>
		<col width="10%"/>
		<col width="10%"/>

		<thead>
			<tr>
				<th>��� ��������</th>
				<th>���-�� ��������</th>
				<th>���-�� ����</th>
				<th>����� �����</th>
				<th>�������� / ������</th>
			</tr>
		</thead>


		<tbody>
			<xsl:for-each select="t:opr-info[count(. | key('currency_key', substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4))[1])=1]">
				<xsl:sort select="@code"/>
				<tr>
					<td><xsl:value-of select="@code"/></td>
					<td class="number_right"><xsl:value-of select="format-number(count(key('currency_key', substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4))), '# ##0', 'unit')"/></td>
					<td class="number_right"><xsl:value-of select="format-number(sum(key('currency_key', substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4))/@unit-qty), '# ##0.000000#', 'unit')"/></td>
					<td class="number_right"><xsl:call-template name="currency_blk"/><xsl:value-of select="format-number(sum(key('currency_key', substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4))/@payment), '# ##0.00##', 'unit')"/></td>
					<td class="number_right"><xsl:call-template name="currency_blk"/><xsl:value-of select="format-number(sum(key('currency_key', substring(concat(@code,'|',@currency, 'RUB'), 1, string-length(@code)+4))/@fee), '# ##0.00##', 'unit')"/></td>
				</tr>
			</xsl:for-each>
		</tbody>
	</table>

</xsl:template>

<xsl:template match="t:opr-info">
	<tr>
		<xsl:element name="td">
			<xsl:if test="t:operation-party">
				<xsl:attribute name="style">border: none;</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="@code"/>
		</xsl:element>

		<td><xsl:value-of select="t:unit-holder/t:unit-account/@num"/> [<xsl:value-of select="t:unit-holder/t:unit-account/@type-code"/>] <xsl:apply-templates mode="common-property-name" select="t:unit-holder/t:unit-account/@common-property-code"/> <xsl:apply-templates select="t:unit-holder/t:unit-account/@is-insurance"/>
		</td>
		<td class="number_right"><xsl:apply-templates select="@unit-qty" mode="uqty"/></td>
		<td class="number_right"><xsl:if test="@unit-price &gt; 0"><xsl:call-template name="price_currency_blk"/> <xsl:apply-templates select="@unit-price" mode="money2"/></xsl:if> 
					<span class="blk" style="color: Blue; font-size: smaller;"><xsl:apply-templates select="@currency-rate" mode="money2"/></span></td>
		<td class="number_right">
			<xsl:if test="@payment &gt; 0"><xsl:call-template name="currency_blk"/> <xsl:apply-templates select="@payment" mode="money2"/></xsl:if>
			<xsl:apply-templates select="t:pmt-info"/>
		</td>
		<td class="number_right"><xsl:if test="@fee &gt; 0"><xsl:call-template name="currency_blk"/> <xsl:apply-templates select="@fee" mode="money2"/></xsl:if></td>

		<td class="number_right">

			<xsl:variable name="v1">
				0<xsl:apply-templates select="@payment" mode="get-number"/>
			</xsl:variable>
			<xsl:variable name="v2">
				0<xsl:apply-templates select="@fee" mode="get-number"/>
			</xsl:variable>
			<xsl:variable name="v3">
				0<xsl:apply-templates select="@currency-rate" mode="get-number"/>
			</xsl:variable>
			
			<xsl:choose>
				<xsl:when test="$v1 &gt; 0">
					<xsl:call-template name="currency_blk"/><xsl:value-of select="format-number(number($v1)-number($v2), '# ##0.00##', 'unit')"/>
				</xsl:when>
				<xsl:otherwise>&nbsp;</xsl:otherwise>
			</xsl:choose>
		</td>

		<td><xsl:apply-templates select="t:operation-cause"/>
		</td>
		<td><xsl:apply-templates mode="str" select="t:unit-holder/t:person"/></td>
	</tr>

	<xsl:if test="t:operation-party">
		<tr>
		<td/>
		<td colspan="8" class="txt2">
			<xsl:apply-templates select="t:operation-party"/>
		</td>
		</tr>
	</xsl:if>

</xsl:template>

<xsl:template match="t:operation-cause">
<span class="blk">
	<xsl:value-of select="@name"/>
</span>
<span class="blk">
	� <xsl:value-of select="@num"/>
</span>
<span class="blk" style="white-space: nowrap;">
	���� <xsl:apply-templates mode="sqldate" select="@date"/>
</span>
	<!--br/>���� ����������� <xsl:apply-templates mode="sqldate" select="@reg-date"/-->
</xsl:template>

<xsl:template match="t:operation-party">
	<xsl:apply-templates select="t:fund"/>
	<xsl:apply-templates select="t:unit-holder/t:person"/>
</xsl:template>

<xsl:template match="t:operation-party/t:fund">
<span class="blk">���� ������: <xsl:value-of select="@fullname"/></span>
</xsl:template>

<xsl:template match="t:operation-party/t:unit-holder/t:person">
<span class="blk">����������: <xsl:value-of select="@fullname"/></span>
</xsl:template>

<xsl:template match="t:pmt-info">
<span style="color: Blue; font-size: smaller;">
	<br/><span style="text-decoration: overline;">����� ������� <xsl:call-template name="currency"/> <xsl:apply-templates select="@payment" mode="money2"/></span>
	<br/>�� � <xsl:value-of select="@num"/> ���� <xsl:apply-templates mode="sqldate" select="@date"/>
	<br/>������� �� <xsl:apply-templates mode="sqldate" select="@stmt-date"/>
	<!--br/>������� � <xsl:value-of select="@stmt-num"/> ���� <xsl:apply-templates mode="sqldate" select="@stmt-date"/-->
</span>
</xsl:template>

<xsl:template match="t:unit-account-info">
	<tr>
		<td><p class="field_data"><xsl:value-of select="@num"/></p></td>
		<td><p class="field_data"><xsl:value-of select="t:person/@fullname"/></p></td>
		<td><p class="field_data"><xsl:apply-templates select="t:unit-account-division/@unit-qty" mode="uqty"/> </p></td>
	</tr>
</xsl:template>

</xsl:stylesheet>