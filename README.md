# Running
Use the commands below to run the image from the [jig](https://github.com/osirrc2019/jig) directory, updating the corpus details as appropriate.

The following corpus are supported:
- `core17`
- `core18`
- `cw09b`
- `cw12b`
- `gov2`
- `robust04`

## Prepare
The following `jig` command can be used to index `robust04`:
```
python run.py prepare \
  --repo osirrc2019/anserini \
  --collections robust04=/home/ryan/sync/ir/collections/disk45=trectext
```

## Search
The following `jig` command can be used to perform a search over `robust04`.
```
python run.py search \
  --repo osirrc2019/anserini \
  --output out/anserini \
  --qrels qrels/qrels.robust2004.txt \
  --topic topics/topics.robust04.txt \
  --collection robust04 \
  --opts search_args="-bm25" out_file_name="run.bm25.robust04"
```
Note: `search_args` and `out_file_name` can be updated for other algorithms (i.e., `search_args="-ql -rm3"` and `out_file_name="run.ql.rm3.robust04"`)
