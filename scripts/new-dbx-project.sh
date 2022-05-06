#!/bin/bash

mkdir -p $1/$2/conf
cd $1/$2
cat << EOT >> ./conf/databricks-config.sh
export DATABRICKS_HOST="${3}"
export DATABRICKS_TOKEN="${4}"
export DATABRICKS_CLUSTER_ID="${5}"
EOT
cat << EOT >> ./conf/deployment.yaml
environments:
    default:
        jobs:
            - name: "${2}-job"
              spark_python_task:
                python_file: "${2}.py"
EOT
dbx configure --profile DEFAULT
cp $1/scripts/pyspark-template.py ./$2.py
cd ..

echo Project ${2} was created!! Add now your pyspark code to file \"${1}/${2}.py\" \(a template was generated\).
