# Running
Use the commands below to run the image from the [jig](https://github.com/osirrc2019/jig) directory, updating the corpus details as appropriate.

## Prepare
```
python run.py prepare \
  --repo osirrc2019/anserini \
  --collections robust04=/home/ryan/sync/ir/collections/disk45=trectext
```

## Search
```
python run.py search \
  --repo osirrc2019/anserini \
  --output $(pwd)/out \
  --qrels qrels/qrels.robust2004.txt \
  --topic topics.robust04.301-450.601-700.txt \
  --collection robust04 \
  --opts search_args="-bm25" out_file_name="run.bm25.robust04"
```
