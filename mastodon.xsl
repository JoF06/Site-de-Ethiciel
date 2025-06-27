<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Définir une clé pour extraire les catégories distinctes -->
    <xsl:key name="categories-key" match="category" use="."/>

    <!-- Modèle principal -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des articles RSS : <xsl:value-of select="title"/></title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/roboto-font@0.1.0/css/fonts.css"/>
                <style>
                    /* Définir la police et la couleur générale de la page */
                    body {
                        font-family: 'Roboto', sans-serif;
                        margin: 0;
                        padding: 0;
                        color: #333; /* Couleur du texte générale */
                        background-color: #f4f4f4; /* Fond de page */
                    }

                    /* Centrer la page avec 15% de marge de chaque côté sur grand écran */
                    .container {
                        width: 60%; /* 100% - 2 * 15% */
                        margin: 0 auto; /* Centrer la page */
                        padding: 20px;
                    }

                    .iframe-center {
                        text-align: center;
                    }

                    a {
                        text-decoration: none;
                        color: inherit;
                    }

                    a:hover {
                        text-decoration: none;
                    }

                    .article {
                        margin-bottom: 20px;
                        padding: 10px;
                        border: 1px solid #ddd;
                        border-radius: 5px;
                        background-color: white; /* Fond des articles */
                    }

                    .article h2 {
                        margin: 0;
                        font-size: 18px;
                    }

                    .article .date {
                        color: #888;
                        font-size: 14px;
                    }

                    .categories {
                        margin-top: 10px;
                    }

                    .category {
                        display: inline-block;
                        padding: 5px 10px;
                        color: white;
                        background-color: #003366; /* Bleu nuit */
                        font-weight: bold;
                        border-radius: 20px;
                        margin-bottom: 10px;
                    }

                    /* Media Query pour les écrans mobiles */
                    @media (max-width: 768px) {
                        /* Sur mobile, la page occupe toute la largeur */
                        .container {
                            width: 100%;
                            padding: 10px;
                        }

                        .article {
                            margin-bottom: 15px;
                            padding: 8px;
                        }

                        .category {
                            font-size: 14px;
                            padding: 4px 8px;
                        }
                    }

                    /* Media Query pour les écrans de taille moyenne (tablettes, petits ordinateurs) */
                    @media (max-width: 1024px) {
                        .container {
                            width: 90%; /* Réduire la largeur pour les écrans de taille moyenne */
                        }
                    }

                    /* Media Query pour les écrans plus grands (ordinateurs de bureau) */
                    @media (min-width: 1025px) {
                        .container {
                            width: 80%; /* Centrer et réduire la largeur sur grand écran */
                        }
                    }
                </style>
            </head>
            <body class="container">
                <h1>Flux RSS : <xsl:value-of select="rss/channel/title"/></h1>
<!--
                <h2>Tous les Tags</h2>

                <div class="categories">
                    <xsl:variable name="distinctCategories" select="rss/channel/item/category[key('categories-key', .)]"/>

                    <xsl:for-each select="$distinctCategories">
                        <xsl:variable name="currentCategory" select="."/>
                        <xsl:variable name="categoryIndex" select="position()"/>
                        <xsl:variable name="colorIndex" select="($categoryIndex - 1) mod 20 + 1"/>

                        <span class="category">
                            <xsl:value-of select="$currentCategory"/>
                        </span>
                    </xsl:for-each>
                </div>
-->
                <h2>Articles</h2>
                <xsl:for-each select="rss/channel/item">
                    <div class="article iframe-center">                        
                        <!-- Titre avec lien -->
                        <xsl:variable name="alink" select="link"/>
                        <iframe src="{$alink}/embed" 
                                class="mastodon-embed iframe-center" 
                                style="max-width: 100%; border: 0" 
                                width="400" 
                                allowfullscreen="allowfullscreen"></iframe>
                        <script src="https://www.framapiaf.org/embed.js" async="async"></script>

                        <!-- Catégories -->
                        <div class="categories">
                            <xsl:for-each select="category[key('categories-key', .)]">
                                <!-- Récupérer la catégorie -->
                                <xsl:variable name="currentCategory" select="."/>

                                <!-- Calculer l'index de la catégorie dans la liste distincte -->
                                <xsl:variable name="categoryIndex" select="position()"/>

                                <!-- Afficher la catégorie avec son index et la couleur -->
                                <span class="category">
                                    <xsl:value-of select="$currentCategory"/>
                                </span>
                            </xsl:for-each>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <!-- Modèle pour formater la date -->
    <xsl:template match="pubDate">
        <xsl:variable name="dateString" select="."/>

        <!-- Extraction du jour -->
        <xsl:variable name="day" select="substring($dateString, 6, 2)"/>

        <xsl:value-of select="$day"/>
        <xsl:text>/</xsl:text>
        <!-- Extraction du mois (conversion texte en chiffre) -->
        <xsl:variable name="monthName" select="substring($dateString, 9, 3)"/>
        <xsl:choose>
            <xsl:when test="$monthName = 'Jan'">01</xsl:when>
            <xsl:when test="$monthName = 'Feb'">02</xsl:when>
            <xsl:when test="$monthName = 'Mar'">03</xsl:when>
            <xsl:when test="$monthName = 'Apr'">04</xsl:when>
            <xsl:when test="$monthName = 'May'">05</xsl:when>
            <xsl:when test="$monthName = 'Jun'">06</xsl:when>
            <xsl:when test="$monthName = 'Jul'">07</xsl:when>
            <xsl:when test="$monthName = 'Aug'">08</xsl:when>
            <xsl:when test="$monthName = 'Sep'">09</xsl:when>
            <xsl:when test="$monthName = 'Oct'">10</xsl:when>
            <xsl:when test="$monthName = 'Nov'">11</xsl:when>
            <xsl:when test="$monthName = 'Dec'">12</xsl:when>
        </xsl:choose>

        <!-- Extraction de l'année -->
        <xsl:variable name="year" select="substring($dateString, 13, 4)"/>
        <xsl:text>/</xsl:text><xsl:value-of select="$year"/>
        <xsl:text> </xsl:text>
        <!-- Extraction de l'heure et des minutes -->
        <xsl:variable name="time" select="substring($dateString, 18, 5)"/>
        <xsl:value-of select=" $time"/>
    </xsl:template>

</xsl:stylesheet>
