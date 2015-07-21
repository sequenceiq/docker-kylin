##Docker Kylin

Kylin is an open source distributed Analytical Engine from eBay to provide SQL interface and multi-dimensional analysis (OLAP) on Hadoop to support TB to PB size analysis.

This is a Docker container for Kylin to help you quick start with. In order to start first pull the container from the Docker repository.

```
docker pull sequenceiq/kylin:0.7.2
```

We have provided a few helper functions for your convenience.

```
wget https://raw.githubusercontent.com/sequenceiq/docker-kylin/master/ambari-functions
source ambari-functions
```

Once the container is pulled you are ready to start playing with Kylin. Use the following functions from `ambari-functions` (make sure you source it).

```
 kylin-deploy-cluster 1
```
(This will start a hadoop cluster with 1 node; It is okay to start the cluster with more than 1 nodes; Kylin will run in the first node 'amb0')


Once the container is up and running you can reach out to the Kylin UI. First you will need to find the IP address of the container:
```
docker inspect -f '{{ .NetworkSettings.IPAddress }}' amb0
```

Once you know the IP address you can use the Kylin UI:

`http://<container_ip>:7070/kylin` (username: ADMIN, password: KYLIN, select a sample project like "learn_kylin" from the project list).

There are a sample Cube has been defined for you, but haven't been built; Select a Cube and then click "Action -> Build",  pick up a date later than 2014-01-01 as the end date; After the job be submitted, watch and track the job progress in the "Jobs" tab until it finished successfully; Once the Cube's status is changed to "READY", you can write some SQL queries in the "Query" tab, for example:
    select part_dt, sum(price) as total_selled, count(distinct seller_id) as sellers from kylin_sales group by part_dt order by part_dt
