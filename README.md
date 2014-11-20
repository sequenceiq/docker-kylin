##Docker Kylin

Kylin is an open source distributed Analytical Engine from eBay to provide SQL interface and multi-dimensional analysis (OLAP) on Hadoop to support TB to PB size analysis.

This is a Docker container for Kylin to help you quick start with. In order to start first pull the container from the Docker repository.

```
docker pull sequenceiq/kylin
```

Once the container is pulled you are ready to start playing with Kylin. Use the following function from `ambari-functions` (make sure you source it).

```
 kylin-deploy-cluster 3
```

Once the container is up and running you can reach out to the Kylin UI. First you will need to find the IP address of the container:
```
docker inspect -f '{{ .NetworkSettings.IPAddress }}' amb0 )
```

Once you know the IP address you can use the Kylin UI:

`http://<container_ip>:7070`.
