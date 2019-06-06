#!/bin/bash

# The Docker repo
REPO="osirrc2019/anserini"
TAG="latest"

# Collection details
COLLECTION_NAME="robust04"
COLLECTION_PATH="/tuna1/collections/newswire/disk45"
COLLECTION_FORMAT="trectext"

TOPIC="topics/topics.robust04.txt"
QRELS="qrels/qrels.robust04.txt"

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.run" search_args="-bm25"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.rm3.run" search_args="-bm25 -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="bm25.ax.run" search_args="-bm25 -axiom -rerankCutoff 20 -axiom.deterministic"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.run" search_args="-ql"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.rm3.run" search_args="-ql -rm3"
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/anserini/$COLLECTION_NAME --opts out_file_name="ql.ax.run" search_args="-ql -axiom -rerankCutoff 20 -axiom.deterministic"
