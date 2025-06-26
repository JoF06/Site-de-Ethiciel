<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:yt="http://www.youtube.com/xml/schemas/2015"
                xmlns:media="http://search.yahoo.com/mrss/"
                xmlns:atom="http://www.w3.org/2005/Atom"                
                version="1.0">
    <xsl:output method="html" indent="yes"/>

    <!-- Modèle principal -->
    <xsl:template match="atom:feed">
        <html>
            <head>
                <title>Flux Vidéos YouTube : <xsl:value-of select="atom:title"/></title>
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
                    .video {
                        margin-bottom: 20px;
                    }
                    .yt {
                        width: 100%;
                        height: 315px;
                        border: none;
                    }
                </style>
            </head>
            <body class="container">
                <h1>Vidéos YouTube de la chaîne <xsl:value-of select="atom:title"/></h1>
                <p>YouTube reste la seule solution pour diffuser des vidéos avec de la musique dont on ne possède pas les droits ...</p>
                <!-- Parcours des entrées du flux -->
                <xsl:for-each select="//atom:entry">
                    <div class="video">
                        <!-- Titre de la vidéo -->
                        <h3>
                            <xsl:value-of select="atom:title"/>
                        </h3>
                        <!-- Vidéo intégrée -->
                        <xsl:variable name="videoId" select="yt:videoId"/>
                        <iframe class="yt"
                                src="https://www.youtube.com/embed/{ $videoId }"
                                title="YouTube video player"
                                frameborder="0"
                                allow="accelerometer; clipboard-write; encrypted-media; picture-in-picture; web-share"
                                referrerpolicy="strict-origin-when-cross-origin"
                                allowwfullscreen="true">
                        </iframe>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
