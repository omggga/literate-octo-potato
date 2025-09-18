<?xml version="1.0" encoding="windows-1251"?>

<!--
������������: ���� ��������

$Revision: 1.2 $
$Date: 2009/01/21 15:22:37 $

-->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:t="http://cabinet.frsd.ru/schema/ufml3/rel-1/"
	xmlns:dsig="http://www.w3.org/2000/09/xmldsig#"
	xmlns:dse="http://cabinet.frsd.ru/schema/xmldsigext-frsd/rel-1/"
	exclude-result-prefixes="xsl t dsig dse"
	version="1.0">

<xsl:include href="html-sys.xsl"/>

<xsl:decimal-format name="unit" decimal-separator="." grouping-separator=" " />

<!--xsl:param name="_base">http://cabinet.frsd.ru/vxsl/</xsl:param-->
	<xsl:param name="_base">/vxsl3/</xsl:param>
	<xsl:param name="_mode"/>
<xsl:param name="data-url"/>

<xsl:variable name="field_name_width" select="'40%'"/>
<xsl:variable name="UnitPrecision" select= "t:envelope/*/t:fund/@unit-precision"/>

<xsl:template name="body_attributes"/>
	
<xsl:template match="/t:envelope">
	
<html>
	<xsl:call-template name="html_head"/>
<body>
	
	<xsl:call-template name="body_attributes"/>

	<xsl:call-template name="xml_source_url"/>

	<xsl:variable name="orient"><xsl:call-template name="orient"/></xsl:variable>

	<div class="R{$orient}"><div class="{$orient}" id="ufmldoc">

	<xsl:apply-templates select="t:*" mode="body"/>

	</div></div>

	<xsl:call-template name="dsig_data"/>

</body>
</html>
</xsl:template>

<xsl:template name="orient">portrait</xsl:template>

<xsl:attribute-set name="form_table">
	<xsl:attribute name="width">100%</xsl:attribute>
	<xsl:attribute name="align">center</xsl:attribute>
	<xsl:attribute name="cellspacing">0</xsl:attribute>
	<xsl:attribute name="cellpadding">3</xsl:attribute>
	<xsl:attribute name="border">0</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="form_table2" use-attribute-sets="form_table">
	<xsl:attribute name="cellspacing">3</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="td_fn">
	<xsl:attribute name="class">td_field_name</xsl:attribute>
	<xsl:attribute name="width">40%</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="td_fd">
	<xsl:attribute name="class">td_field_data_top</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="inline-css">
	<style type="text/css">
		<xsl:comment>
			<xsl:call-template name="page-css"/>
		</xsl:comment>
	</style>
</xsl:template>

<xsl:template name="page-css"/>
<xsl:template name="js-links"/>
	
<xsl:template name="html_meta">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</xsl:template>

<xsl:template name="html_title1"/>

<xsl:template name="html_head">
	<xsl:element name="head">
		
		<xsl:variable name="dev_base" select="/processing-instruction('frsd-dev-base')"/>
		
		<xsl:choose>
			<xsl:when test="$dev_base">
				<base href="{$dev_base}"/>
			</xsl:when>
			<xsl:otherwise>
				<base href="{$_base}"/>
			</xsl:otherwise>
		</xsl:choose>
				
		<xsl:call-template name="html_meta"/>

		<link href="ufml.css" type="text/css" rel="stylesheet" />
		<link href="ufml_s.css" type="text/css" rel="stylesheet" media="screen"/>
		<link href="ufml_p.css" type="text/css" rel="stylesheet" media="print"/>

		<xsl:call-template name="html_title"/>
		<xsl:call-template name="inline-css"/>
		<xsl:call-template name="js-links"/>
		<!--title/-->
	</xsl:element>
</xsl:template>

<xsl:template name="�_��������">
	<div style="zoom: 1;">
		<span class="field_comment" style="float: right; text-decoration: underline"><xsl:value-of select="@form"/></span>
		<xsl:apply-templates mode="regnum" select="@reg-num[. and . != '']"/>
		<span style="clear: all"><xsl:comment/></span>
	</div>
</xsl:template>

<xsl:template name="�_���������">
	<xsl:call-template name="�_��������"/>

	<h1><xsl:value-of select="@name"/>
		<br/><span class="std_font" style="text-align: center">�������� ���� &#160;<xsl:apply-templates mode="sqldate" select="@oper-date"/></span>
	</h1>
</xsl:template>

<xsl:template name="�_���������1">
	<xsl:call-template name="�_��������"/>
	
	<h1><xsl:value-of select="@name"/></h1>
</xsl:template>

<xsl:template name="�_����_���">
	<table xsl:use-attribute-sets="form_table" class="form_table" rules="rows">
		<col width="40%"/>
		<tr>
			<th>������ ������������ ������� ��������������� ����� (����� - ����)</th>
			<td><xsl:value-of select="t:fund/@fullname"/></td>
		</tr>
		<xsl:if test="t:fund/@rule-num">
			<tr style="border-top: 1pt dotted lightgray">
				<th>��������������� �����</th>
				<td><xsl:value-of select="t:fund/@rule-num"/></td>
			</tr>
		</xsl:if>
		<tr style="border-top: 1pt dotted lightgray">
			<th>����������� ��������</th>
			<td><xsl:value-of select="t:fund/t:fund-subject[@subject-code='��']/@fullname"/></td>
		</tr>
		<xsl:if test="t:fund/t:fund-subject[@subject-code='��']/@num">
			<tr style="border-top: 1pt dotted lightgray">
				<th>����</th>
				<td><xsl:value-of select="t:fund/t:fund-subject[@subject-code='��']/@num"/></td>
			</tr>
		</xsl:if>
	</table>
</xsl:template>

<xsl:template name="�_����">
	<div class="fund_header">
		<p class="field_name">������ ������������ ������� ��������������� ����� (����� - ����)</p>
		<p class="fund_name"><xsl:value-of select="t:fund/@fullname"/></p>
		<xsl:if test="t:fund/@rule-num">
		<p class="field_name" style="text-align: center" >��������������� �����: </p> <p class="fund_name" style="text-align: center"><xsl:value-of select="t:fund/@rule-num"/></p>
		</xsl:if>
		<p class="field_name">����������� ��������</p>
		<p class="fund_mc_name"><xsl:value-of select="t:fund/t:fund-subject[@subject-code='��']/@fullname"/></p>
		<xsl:if test="t:fund/t:fund-subject[@subject-code='��']/@num">
			<p class="std_font" style="text-align: center">����: <xsl:value-of select="t:fund/t:fund-subject[@subject-code='��']/@num"/></p>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="@reg-num" mode="regnum">
	<span style="float: left; text-align: right; font-size: 75%;">���. � <xsl:value-of select="."/>; ���� <xsl:apply-templates mode="sqldate-date" select="../@reg-date"/></span>
</xsl:template>

	<xsl:template name="���������-�������">
		
		<div class="form_frame" style="margin-top: 0em;">
			
			<table xsl:use-attribute-sets="form_table"  class="form_table" rules="rows">
				<col width="40%"/>
				<col/>
				<tbody>
					<tr>
						<th>����� � ��� �������� �����</th>
						<td><xsl:value-of select="t:unit-account-info/@num"/> (<xsl:value-of select="t:unit-account-info/@name"/>) <xsl:apply-templates mode="common-property-name" select="t:unit-account-info/@common-property-code"/><xsl:apply-templates select="t:unit-account-info/@is-insurance"/></td>
					</tr>
					<tr>
						<th>����, �� ������� ������� ������������ ������ �����<span class="note">(������ �������������� �� ����� ���)</span></th>
						<td><xsl:apply-templates mode="sqldate" select="../@oper-date"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</xsl:template>
	

<xsl:template name="�������_�������">
<div style="margin-top: 2cm;">
	<p style="font-size: 7pt; text-align: center">������� ��������������� ���� ������������ _______________________________</p>
	<p style="font-size: 7pt; text-align: center; margin-top: 20px;">�.�.</p>
</div>
</xsl:template>

<xsl:template name="�������_��">
<div style="margin-top: 2cm;">
	<p style="font-size: 7pt; text-align: center">������� _______________________________</p>
	<p style="font-size: 7pt; text-align: center; margin-top: 20px;">�.�.</p>
</div>
</xsl:template>

<xsl:template name="�����_����">
<div style="margin-top: 0px; border-bottom: #C0C0C0 1pt solid;">
	<p style="font-size: 8pt; font-weight: bold; text-align: center">��� "������ ������������������ �����������"</p>
	<p style="font-size: 7pt; text-align: center;">����:1027700373678, �������� �����: 125167 ������, 4-� ��. 8 �����, �. 6�. ���: +7 (495) 223-6607</p>
</div>
</xsl:template>

<xsl:template mode="�_��������_��" match="t:person">
	<tr>
		<th>�.�.�./������ ������������</th>
		<td><xsl:value-of select="@fullname"/></td>
	</tr>
	
	<xsl:apply-templates mode="form" select="t:document"/>
	<xsl:apply-templates mode="�_��������_��" select="@share"/>
</xsl:template>

<xsl:template mode="�_��������_��" match="@share">
	<tr>
		<th>����</th>
		<td><xsl:value-of select="."/></td>
	</tr>
</xsl:template>

<xsl:template mode="form" match="t:document">
	<tr>
		<th>��������, �������������� ��������/ �������� � ��������������� ����������� ������������ ����</th>
		<td>	<xsl:value-of select="@name"/>&#160;
				<xsl:value-of select="@ser"/>&#160;
				<xsl:value-of select="@num"/>
				<xsl:text>, ����� </xsl:text>
				<xsl:apply-templates mode="sqldate" select="@date"/>&#160;<xsl:value-of select="@sertified"/>
		</td>
	</tr>
</xsl:template>

<xsl:template name="dsig_data">
	<xsl:apply-templates select="dsig:Signature" mode="dsig_data"/>
</xsl:template>

<xsl:template match="dsig:Signature" mode="dsig_data">
<div class="dsig_block noprint">
	<span class="h">������ ���</span>
	<xsl:apply-templates select="dsig:KeyInfo/dsig:X509Data"/>
	<xsl:apply-templates select="dsig:Object/dsig:SignatureProperties"/>
	<xsl:apply-templates select="dsig:SignatureValue"/>
</div>
</xsl:template>

<xsl:template match="dsig:KeyInfo/dsig:X509Data">
	<xsl:variable name="cert-path" select="processing-instruction('frsd-cert-path')"/>
	<div>
		<span class="h">�������� �����������:</span>
		<a href="{$cert-path}" class="v" title="���������� ����������">
			<xsl:value-of disable-output-escaping="yes" select="dsig:X509Certificate/processing-instruction('frsd-cert-CommonName')"/>
			&#160;&#160;&#32;[<xsl:value-of disable-output-escaping="yes" select="dsig:X509Certificate/processing-instruction('frsd-cert-OrganizationName')"/>]
		</a>
	</div>
</xsl:template>

<xsl:template match="dsig:Object/dsig:SignatureProperties">
	<xsl:apply-templates select="dsig:SignatureProperty"/>
</xsl:template>

<xsl:template match="dsig:SignatureProperty">
	<div>
		<span class="h">����� ������� �� �������� (SignatureTime):</span> 
		<span class="v"><xsl:apply-templates select="dse:Events/@SignatureTime" mode="dsigdate"/></span> 
	</div>
</xsl:template>


<xsl:template match="dsig:SignatureValue">
	<div>
		<span class="h">�������� ��� (SignatureValue):</span> 
		<span class="vbin"><xsl:value-of select="."/></span> 
	</div>
</xsl:template>

<xsl:template name="xml_source_url">
	<xsl:if test="starts-with($data-url, 'http://') or starts-with($data-url, 'frsd://')">
		<xsl:if test="contains($data-url, '/doc/id/')">
			<a href="{concat(substring-before($data-url,'&amp;'), '&amp;get=Ufml3')}" class="noprint">��������� ��� XML+Ufml3</a>
		</xsl:if>
	</xsl:if>
</xsl:template>

<xsl:template mode="str" match="t:document">
	<xsl:value-of select="@name"/>&#160;
	<xsl:value-of select="@ser"/>&#160;
	<xsl:value-of select="@num"/>
</xsl:template>

<xsl:template mode="str" match="t:person">
	<xsl:value-of select="@fullname"/>
	<span class="blk">[<xsl:apply-templates mode="str" select="t:document"/>]</span>
	<xsl:apply-templates mode="person" select="@share"/>
</xsl:template>

<xsl:template mode="person" match="@share">
 <span class="blk"><span class="field_name nowrap">���� - </span><xsl:value-of select="."/></span>
</xsl:template>

<xsl:template mode="uqty" match="@*">
	<xsl:call-template name="RoundedDecimalFormat">
		<xsl:with-param name="num" select="."/>
		<xsl:with-param name="digitCount" select="$UnitPrecision"/>
	</xsl:call-template>
</xsl:template>

<xsl:template mode="uqty2" match="@*[.=0]">
	<xsl:text>0</xsl:text>
</xsl:template>

<xsl:template mode="uqty2" match="@*">

	<xsl:call-template name="RoundedDecimalFormat">
		<xsl:with-param name="num" select="."/>
		<xsl:with-param name="digitCount" select="$UnitPrecision"/>
	</xsl:call-template>

</xsl:template>

<xsl:template name="uqty_sum">
	<xsl:param name="num"></xsl:param>
	
	<xsl:call-template name="RoundedDecimalFormat">
		<xsl:with-param name="num" select="$num"/>
		<xsl:with-param name="digitCount" select="$UnitPrecision"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="RoundedDecimalFormat">
	<xsl:param name="num"></xsl:param>
	<xsl:param name="digitCount"></xsl:param>
	
	<xsl:choose>
		<xsl:when test="$digitCount = 7"><xsl:value-of select="format-number($num, '# ##0.0000000#', 'unit')"/></xsl:when>
		<xsl:when test="$digitCount = 6"><xsl:value-of select="format-number($num, '# ##0.000000##', 'unit')"/></xsl:when>
		<xsl:when test="$digitCount = 5"><xsl:value-of select="format-number($num, '# ##0.00000###', 'unit')"/></xsl:when>
		<xsl:when test="$digitCount = 4"><xsl:value-of select="format-number($num, '# ##0.0000####', 'unit')"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="format-number($num, '# ##0.000000##', 'unit')"/></xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template mode="money" match="@*">
<xsl:value-of select="format-number(., '# ##0.0000', 'unit')"/>
</xsl:template>

<xsl:template mode="money2" match="@*">
<xsl:value-of select="format-number(., '# ##0.00##', 'unit')"/>
</xsl:template>

<xsl:template match="@*" mode="get-number">
	<xsl:choose>
		<xsl:when test="string(number(.)) != 'NaN'"><xsl:value-of select="."/></xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="html_title">
	<xsl:apply-templates select="/t:envelope/t:*/@name" mode="title"/>
</xsl:template>

<xsl:template match="@name" mode="title">
	<title><xsl:value-of select="."/></title>
</xsl:template>

<xsl:template name="currency_blk">
	<span style="color: grey;">
		<xsl:call-template name="currency"/> 
	</span>
</xsl:template>

<xsl:template name="price_currency_blk">
	<span style="color: grey;">
		<xsl:call-template name="price-currency"/> 
	</span>
</xsl:template>

<xsl:template name="price-currency">
	<xsl:call-template name="currency_code">
      <xsl:with-param name="n"><xsl:value-of select="@price-currency"/></xsl:with-param>
   </xsl:call-template>
</xsl:template>

<xsl:template name="currency">
	<xsl:call-template name="currency_code">
      <xsl:with-param name="n"><xsl:value-of select="@currency"/></xsl:with-param>
   </xsl:call-template>
</xsl:template>

<xsl:template name="currency_code">
    <xsl:param name="n"/>
	
	<xsl:choose>
		<xsl:when test="$n = 'USD'">$ </xsl:when>
		<xsl:when test="$n = 'RUB'">&#8381; </xsl:when>
		<xsl:when test="string($n)=''">&#8381; </xsl:when>
		<xsl:when test="$n = 'EUR'">� </xsl:when>
		<xsl:otherwise><xsl:value-of select="$n"/> </xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="oper-text">
	<xsl:choose>
	<xsl:when test="@code = '����'">�������� �������� �����</xsl:when>
	<xsl:when test="@code = '���'">��������� ������</xsl:when>
	<xsl:when test="@code = '���'">��������� ������</xsl:when>
	<xsl:when test="@code = '���'">����������� �������</xsl:when>
	<xsl:when test="@code = '���'">����������� ������</xsl:when>
	<xsl:when test="@code = '���'">�������� ����� ������</xsl:when>
	<xsl:when test="@code = '����'">�������� �������� �����</xsl:when>
	<xsl:when test="@code = '���'">��������� �������� ������</xsl:when>
	<xsl:when test="@code = '���'">��������� ������� ������</xsl:when>		
	<xsl:when test="@code = '���'">����������� ������</xsl:when>
	<xsl:when test="@code = '����'">����������� ������</xsl:when>
	<xsl:when test="@code = '�����'">������ ������������ ����</xsl:when>
	<xsl:when test="@code = '����'">������������ ����</xsl:when>
	<xsl:when test="@code = '�����'">�������������� �������</xsl:when>
	<xsl:when test="@code = '�����'">��������� ������ �� ����� "���������� ���"</xsl:when>
	<xsl:when test="@code = '�����'">��������� ������ �� ����� "���������� ���"</xsl:when>
	<xsl:when test="@code = '�����'">������������ �� ������������� ������������ �����������</xsl:when>
	<xsl:when test="@code = '�����'">������ ������������ ����� ������������� ������������ �����������</xsl:when>
	<xsl:when test="@code = '�����'">����������� ��������</xsl:when>
	<xsl:when test="@code = '�����'">������ ����������� ��������</xsl:when>
	<xsl:when test="@code = '�����'">����� �������</xsl:when>
	<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>	
	<xsl:otherwise><xsl:value-of select="@code"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="@common-property-code" mode="common-property">
	<xsl:choose>
	<xsl:when test=". = '�'"></xsl:when>
	<xsl:when test=". = '���'"></xsl:when>
	<xsl:when test=". = '�'">[���]</xsl:when>
	<xsl:when test=". = '���'">[���]</xsl:when>
	<xsl:when test=". = '�'">[����]</xsl:when>
	<xsl:when test=". = '���'">[����]</xsl:when>
	<xsl:otherwise>[<xsl:value-of select="."/>]</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="@common-property-code" mode="common-property-name">
	<xsl:choose>
	<xsl:when test=". = '�'"></xsl:when>
	<xsl:when test=". = '���'"></xsl:when>
	<xsl:when test=". = '�'">�������</xsl:when>
	<xsl:when test=". = '���'">�������</xsl:when>
	<xsl:when test=". = '�'">����������</xsl:when>
	<xsl:when test=". = '���'">����������</xsl:when>
	<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="@common-property-code" mode="common-property-name2">
	<xsl:choose>
	<xsl:when test=". = '�'">���</xsl:when>
	<xsl:when test=". = '���'">���</xsl:when>
	<xsl:when test=". = '�'">�������</xsl:when>
	<xsl:when test=". = '���'">�������</xsl:when>
	<xsl:when test=". = '�'">����������</xsl:when>
	<xsl:when test=". = '���'">����������</xsl:when>
	<xsl:otherwise>[<xsl:value-of select="."/>]</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="@is-insurance">
	<xsl:choose>
	<xsl:when test=". = 1">[���]</xsl:when>
	<xsl:when test=". = 'true'">[���]</xsl:when>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>