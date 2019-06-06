#!/bin/bash

# The Docker repo
REPO="osirrc2019/anserini"
TAG="latest"

# Collection details
COLLECTION_NAME="gov2"
COLLECTION_PATH="/tuna1/collections/web/gov2"
COLLECTION_FORMAT="trectext"

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.701-750.run" search_args="-bm25"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.751-800.run" search_args="-bm25"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.801-850.run" search_args="-bm25"

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.701-750.rm3.run" search_args="-bm25 -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.751-800.rm3.run" search_args="-bm25 -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.801-850.rm3.run" search_args="-bm25 -rm3"

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.701-750.ax.run" search_args="-bm25 -axiom -axiom.beta 0.1 -rerankCutoff 20 -axiom.deterministic"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.751-800.ax.run" search_args="-bm25 -axiom -axiom.beta 0.1 -rerankCutoff 20 -axiom.deterministic"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.801-850.ax.run" search_args="-bm25 -axiom -axiom.beta 0.1 -rerankCutoff 20 -axiom.deterministic"

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.701-750.run" search_args="-ql"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.751-800.run" search_args="-ql"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.801-850.run" search_args="-ql"

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.701-750.rm3.run" search_args="-ql -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.751-800.rm3.run" search_args="-ql -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.801-850.rm3.run" search_args="-ql -rm3"

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.701-750.txt --qrels qrels.701-750.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.701-750.ax.run" search_args="-ql -axiom -rerankCutoff 20 -axiom.beta 0.1 -axiom.deterministic"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.751-800.txt --qrels qrels.751-800.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.751-800.ax.run" search_args="-ql -axiom -rerankCutoff 20 -axiom.beta 0.1 -axiom.deterministic"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic topics.801-850.txt --qrels qrels.801-850.txt --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.801-850.ax.run" search_args="-ql -axiom -rerankCutoff 20 -axiom.beta 0.1 -axiom.deterministic"
