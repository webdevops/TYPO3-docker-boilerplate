[<-- Back to Services section](../../documentation/SERVICES.md)

# TYPO3 Solr Server Support

You find the official version matrix "TYPO3 - Solr TYPO3 Extension - Solr Server" in the [official documentation of ext:solr](https://docs.typo3.org/typo3cms/extensions/solr/Appendix/VersionMatrix.html).

## Out-of-the-box supported solr configurations:


EXT:solr version | TYPO3 version | Solr Container Build context
-----------------|---------------|---------------------------------
5.1              | 8.0           | `docker/solr/ext-solr-5.1/`
5.1              | 7.6           | `docker/solr/ext-solr-5.1/`
5.0              | 8.0           | `docker/solr/ext-solr-4.0-5.0/`
5.0              | 7.6 (LTS)     | `docker/solr/ext-solr-4.0-5.0/`
4.0              | 8.0           | `docker/solr/ext-solr-4.0-5.0/`
4.0              | 7.6 (LTS)     | `docker/solr/ext-solr-4.0-5.0/`
3.1              | 7.6 (LTS)     | `docker/solr/ext-solr-3.1/`
3.1              | 6.2 (LTS)     | `docker/solr/ext-solr-3.1/`
3.0              | 6.2 (LTS)     | `docker/solr/ext-solr-3.0/`
3.0              | 4.5 (LTS)     | `docker/solr/ext-solr-3.0/`



### How to set build context

Simply use the appropriate value from the table above as build context in your `docker-compose.yml` like

    solr:
      build:
        context: docker/solr/ext-solr-5.1/
