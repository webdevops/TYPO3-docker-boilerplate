[<-- Back to Services section](../../documentation/SERVICES.md)

# TYPO3 Solr Server Support

You find the official version matrix "TYPO3 - Solr TYPO3 Extension - Solr Server" in the [official documentation of ext:solr](https://docs.typo3.org/typo3cms/extensions/solr/Appendix/VersionMatrix.html).

## Out-of-the-box supported solr configurations:



## EXT:solr 3.1 + TYPO3 6.2-7.6 + Solr Server 4.10.4

Make sure to use context `docker/solr/ext-solr-3.1/` in your `docker-compose.yml` like

    solr:
      build:
        context: docker/solr/ext-solr-3.1/



## EXT:solr 3.0.2 + TYPO3 4.5-6.2 + Solr Server 4.9.0

Make sure to use context `docker/solr/ext-solr-3.0/` in your `docker-compose.yml` like

    solr:
      build:
        context: docker/solr/ext-solr-3.0/
