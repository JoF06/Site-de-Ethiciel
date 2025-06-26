<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- Modèle principal -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des articles ATOM : <xsl:value-of select="atom:title"/></title>
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
                <div class="iframe-center">
                    <h1>Flux ATOM : <xsl:value-of select="atom:feed/atom:title"/></h1>

                    <h2>Posts</h2>
                </div>
                <xsl:for-each select="atom:feed/atom:entry">
                    <xsl:variable name="title" select="atom:title"/>
                    <div class="iframe-center">
                        <iframe title="$title" src="{atom:link/@href}/embed?caption=true&amp;likes=false&amp;layout=full" class="pixelfed__embed" style="max-width: 100%; border: 0" width="400" allowfullscreen="allowfullscreen"></iframe>
                        <script async="true" defer="true" src="https://pixelfed.fr/embed.js"></script>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <!-- Modèle pour formater la date -->
    <xsl:template match="atom:published">
        <xsl:param name="dateString" select="."/>
        <xsl:variable name="year" select="substring($dateString, 1, 4)"/>
        <xsl:variable name="month" select="substring($dateString, 6, 2)"/>
        <xsl:variable name="day" select="substring($dateString, 9, 2)"/>
        <xsl:variable name="hour" select="substring($dateString, 12, 2)"/>
        <xsl:variable name="minute" select="substring($dateString, 15, 2)"/>
        <xsl:value-of select="concat($day, '/', $month, '/', $year, ' ', $hour, ':', $minute)"/>
    </xsl:template>
</xsl:stylesheet>
