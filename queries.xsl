<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dc="http://dublincore.org/documents/dcmi-namespace/"
                xmlns:aqd="http://aurora-network.global/queries/namespace/"
                exclude-result-prefixes="xsl aqd dc">

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <!-- The above 3 meta tags *must* come first in the head; any other head
                    content must come *after* these tags -->
                <meta name="description" content=""/>
                <meta name="author" content=""/>
                <!-- <link rel="icon" href="img/favicon.ico" /> -->
                <title>Search Queries for "Mapping Research Output to the Sustainable Development Goals (SDGs)"</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
                      integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
                      crossorigin="anonymous"></link>
                <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"
                        integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
                        crossorigin="anonymous" ></script>-->
				<script src="https://kit.fontawesome.com/903201d2a3.js" crossorigin="anonymous"></script>
            </head>
            <body>
                <div class="jumbotron">
                    <div class="container">
                        <h1><i class="fas fa-university"></i> Aurora SDG Search Queries <i class="fas fa-search"></i></h1>
                        <h2> Search Queries for "Mapping Research Output to the Sustainable Development Goals (SDGs)" </h2>
						<p> <i class="fas fa-project-diagram"></i> <a href="https://aurora-network.global/project/sdg-analysis-bibliometrics-relevance/" target="_blank"> Project: SDG analysis Biliometrics of Relevance | Societal Impact and Relevance of Research </a> </p>
						<p> <i class="fas fa-code-branch"></i> <a href="https://github.com/Aurora-Network-Global/sdg-queries" target="_blank"> Contribute on Github </a> <i class="fab fa-github"></i></p>
                    </div>
                </div>
                <div class="container">
                    <xsl:apply-templates select="aqd:query"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="aqd:queries">
        <xsl:apply-templates select="aqd:query"/>
    </xsl:template>

    <xsl:template match="aqd:query">
      <div style="display:table">
        <div style="display:table-cell"><img src="{icon}" height="100px"/></div>
        <div style="display:table-cell"><a href="{dc:subject}"><h2><xsl:value-of select="dc:title/."/> </h2></a> </div>
      </div>
		<p><xsl:value-of select="dc:description"/></p>
        <p>Version: <strong><xsl:value-of select="dc:identifier[@type='version']" /></strong> | doi:<xsl:value-of select="dc:identifier[@type='doi']" /></p>
		<p>Last updated: <xsl:value-of select="dc:date"/> </p>
		<p>Created by: <xsl:value-of select="dc:creator" /></p>
		<p>License: <xsl:value-of select="dc:rights" /> | <xsl:value-of select="dc:rights/@href" /> </p>
		<p>Usage: Go to <a href="https://scopus.com">www.scopus.com</a> , and copy-paste the search queries in "Advanced Search". For the combined search string, scroll to bottom. </p>
        <xsl:apply-templates select="aqd:query-definitions"/>
    </xsl:template>

    <xsl:template match="aqd:query-definitions">
        <table class="table table-striped" border="1">
            <thead>
                <tr bgcolor="#9acd32">
                    <th>Target</th>
                    <th>Description</th>
                    <th>Query</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td/>
                    <td/>
                    <td>
                        (
                    </td>
                </tr>
                <xsl:apply-templates select="aqd:query-definition" mode="table"/>
                <tr>
                    <td/>
                    <td/>
                    <td>
                        )
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>Filter:</td>
                    <td>
                        <xsl:apply-templates select="aqd:filters"/>
                    </td>
                </tr>
            </tbody>
        </table>

		<hr/>
        <div>
            (<xsl:apply-templates select="aqd:query-definition" mode="query"/>)
            <xsl:apply-templates select="aqd:filters"/>
        </div>


    </xsl:template>

    <xsl:template match="aqd:query-definition" mode="table">
        <tr>
            <td>
                <xsl:value-of select="../../dc:identifier"/>.
                <xsl:value-of select="aqd:subquery-identifier"/>
            </td>
            <td>
                <xsl:apply-templates select="aqd:subquery-descriptions"/>
            </td>
            <td>
                <xsl:if test="count(aqd:query-lines/aqd:query-line) > 0">
                    <xsl:if test="aqd:query-lines/aqd:query-line/. != ''">
                        <xsl:if test="position() != 1">
                            <xsl:text>OR</xsl:text>
                        </xsl:if>
                        <xsl:apply-templates select="aqd:query-lines"/>
                        <xsl:apply-templates select="aqd:filters"/>
                    </xsl:if>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="aqd:query-definition" mode="query">
        <xsl:if test="count(aqd:query-lines/aqd:query-line) > 0">
            <xsl:if test="aqd:query-lines/aqd:query-line/. != ''">
                <xsl:if test="position() != 1">
                    <xsl:text>OR</xsl:text>
                </xsl:if>
                <xsl:apply-templates select="aqd:query-lines"/>
                <xsl:apply-templates select="aqd:filters"/>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="aqd:subquery-descriptions">
        <xsl:apply-templates select="aqd:subquery-description"/>
    </xsl:template>

    <xsl:template match="aqd:subquery-description">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>

    <xsl:template match="aqd:query-lines">
        <font face="Courier, monospace">
            <xsl:if test="@field">
                <xsl:value-of select="@field"/>(
            </xsl:if>
            <xsl:apply-templates select="aqd:query-line"/>
            <xsl:if test="@field">
                )
            </xsl:if>
        </font>
    </xsl:template>

    <xsl:template match="aqd:query-line">
        <p>
            <font face="Courier, monospace">
                <xsl:if test="@field">
                    <xsl:value-of select="@field"/>
                </xsl:if>
                (<xsl:value-of select="."/>)
                <xsl:if test="position() != last()">
                    <xsl:text> OR </xsl:text>
                    <xsl:text>&#xa;</xsl:text>
                </xsl:if>
            </font>
        </p>
    </xsl:template>

    <xsl:template match="aqd:filters">
        <xsl:if test="aqd:timerange">
            <p>
                <font face="Courier, monospace">
                     AND (
                    <xsl:value-of select="aqd:timerange/@field"/>
                    &gt;
                    <xsl:value-of select="aqd:timerange/aqd:start/."/>
                     AND
                    <xsl:value-of select="aqd:timerange/@field"/>
                    &lt;
                    <xsl:value-of select="aqd:timerange/aqd:end/."/>
                    )
                </font>
            </p>
        </xsl:if>
        <xsl:if test="aqd:filter">
            <xsl:if test="aqd:filter !=''">
                <font face="Courier, monospace">
                    <xsl:if test="position() != last()">
                        AND
                    </xsl:if>
                    <p>
                        (<xsl:apply-templates select="aqd:filter"/>)
                    </p>
                </font>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="aqd:filter">
        <font face="Courier, monospace">
            <xsl:value-of select="@field"/>(<xsl:value-of select="."/>)
        </font>
    </xsl:template>
</xsl:stylesheet>
