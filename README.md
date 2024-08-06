# End-to-End Data Pipeline

This repository contains the code for an end-to-end Arpache Airflow data pipeline with Docker container which extracts data from both csv and Postgres database into S3 buckets (using minio); then processes the data using Apache Spark and loads the data into bucktets. Then utilizes python scripts to analyze and build User Behaviour Metric and stores it in DuckDB (as a warehouse). Finally the data visualization is done using Quarto and Plotly.

## Architecture

The architecture of the data pipeline is as follows:

1. **`Airflow`** is used to orchestrate the data pipeline, DAGs.
2. **`Postgres`** is used to store Airflow's metadata and the data to be processed.
3. **`DuckDB`** is acted as a data warehouse to store the processed data.
4. **`Quarto with Plotly`** are used to convert code in `markdown` format to html files that can be embedded in the app or servered as is.
5. **`Apache Spark`** is used to process the data and run a [classification algorithm](./dags/user_analytics.py).
6. **`minio`**: To provide an S3 compatible open source storage system.


![flowchart](./screenshots/flowchart.png)

## Screenshots

### Airflow Running DAG
![Dag](./screenshots/dag.png)

### Airflow running with Docker
![airflow](./screenshots/airflow.png)
![airflow_dag](./screenshots/airflow_dag.png)

#### Docker
![docker_compose_build](./screenshots/docker_compose_build.png)
![docker_images](./screenshots/docker_images.png)

### Interactive Dashboard with Quatro and Plotly
![dashboard](./screenshots/dashboard.png)

You can view the dashboard html rendered file [here](./dags/scripts/dashboard/dashboard.html)

