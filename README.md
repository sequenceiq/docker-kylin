##Docker Kylin

Kylin is an open source distributed Analytical Engine from eBay to provide SQL interface and multi-dimensional analysis (OLAP) on Hadoop to support TB to PB size analysis.

This is a Docker container for Kylin to help you quick start with. In order to start first pull the container from the Docker repository.

```
docker pull sequenceiq/kylin:0.6.4
```

We have provided a few helper functions for your convenience.

```
wget https://raw.githubusercontent.com/sequenceiq/docker-kylin/master/ambari-functions
source ambari-functions
```

Once the container is pulled you are ready to start playing with Kylin. Use the following functions from `ambari-functions` (make sure you source it).

```
 kylin-deploy-cluster 3
```
(This will start a hadoop cluster with 3 ndoes; Kylin will run in the first node 'amb0'; It is okay to start the cluster with 1 node)


Once the container is up and running you can reach out to the Kylin UI. First you will need to find the IP address of the container:
```
docker inspect -f '{{ .NetworkSettings.IPAddress }}' amb0
```

Once you know the IP address you can use the Kylin UI:

`http://<container_ip>:7070` (username: ADMIN, password: KYLIN, select a sample project like "default" from the project list).

There are a couple of sample Cubes have been defined for you, but haven't been built; Select a Cube and then click "Action -> Build" to trigger the hadoop jobs; track the job progress in the "Jobs" tab until it finished successfully; Once the Cube's status is changed to "READY", you can write some SQL queries and test the cube.  
