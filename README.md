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

# Reference Image Details

The following is a quick breakdown of what happens in each of the scripts in this repo.

## Dockerfile

The `Dockerfile` installs dependencies (`python3`, etc.), copies scripts to the root dir, and sets the working dir to `/work`.

## init

The `init` [script](init) is straightforward - it's simply a shell script (via the `#!/usr/bin/env sh` she-bang) that invokes `wget` to download an `anserini` JAR from Maven Central.

## index

The `index` [script](index) reads a JSON string (see [here](https://github.com/osirrc/jig#index)) containing at least one collection to index (including the name, path, and format).
The collection is indexed and placed in a directory, with the same name as the collection, in the working dir (i.e., `/work/robust04`).
At this point, `jig` takes a snapshot and the indexed collections are persisted for the `search` hook.

## search

The `search` [script](search) reads a JSON string (see [here](https://github.com/osirrc/jig#search)) containing the collection name (to map back to the index directory from the `index` hook) and topic path, among other options.
The retrieval run is performed (using additional `--opts` params, see above) and output is placed in `/output` for the `jig` to evaluate using `trec_eval`.