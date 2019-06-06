# Anserini OSIRRC Docker Image

[![Build Status](https://travis-ci.com/osirrc/anserini-docker.svg?branch=master)](https://travis-ci.com/osirrc/anserini-docker)

TODO: fix badge?

[**Ryan Clancy**](https://github.com/r-clancy/) and [**Jimmy Lin**](https://github.com/lintool/)

This is the docker image for the [Anserini](http://anserini.io/) toolkit (v0.5.0) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC 2019) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/anserini
) has been tested with the jig at commit [ca31987](https://github.com/osirrc/jig/commit/ca3198704795f2b6de8b78ed7a66bbdf1dccadb1) (6/5/2019).

+ Supported test collections: `core17`, `core18`, `cw09b`, `cw12b`, `gov2`, `robust04`
+ Supported hooks: `init`, `index`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare \
  --repo osirrc2019/anserini \
  --collections robust04=/path/to/disk45=trectext
```

The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python run.py search \
  --repo osirrc2019/anserini \
  --output out/anserini \
  --qrels qrels/qrels.robust04.txt \
  --topic topics/topics.robust04.txt \
  --collection robust04 \
  --opts search_args="-bm25" out_file_name="run.bm25.robust04"
```

The arguments `search_args` and `out_file_name` can be customized (i.e., `search_args="-ql -rm3"` and `out_file_name="run.ql.rm3.robust04"`)

## Expected Results

TODO: add expected AP, etc.

## Implementation

The following is a quick breakdown of what happens in each of the scripts in this repo.

### Dockerfile

The `Dockerfile` installs dependencies (`python3`, etc.), copies scripts to the root dir, and sets the working dir to `/work`.

### init

The `init` [script](init) is straightforward - it's simply a shell script (via the `#!/usr/bin/env sh` she-bang) that invokes `wget` to download an `anserini` JAR from Maven Central.

### index

The `index` Python [script](index) (via the `#!/usr/bin/python3 sh` she-bang) reads a JSON string (see [here](https://github.com/osirrc/jig#index)) containing at least one collection to index (including the name, path, and format).
The collection is indexed and placed in a directory, with the same name as the collection, in the working dir (i.e., `/work/robust04`).
At this point, `jig` takes a snapshot and the indexed collections are persisted for the `search` hook.

### search

The `search` [script](search) reads a JSON string (see [here](https://github.com/osirrc/jig#search)) containing the collection name (to map back to the index directory from the `index` hook) and topic path, among other options.
The retrieval run is performed (using additional `--opts` params, see above) and output is placed in `/output` for the `jig` to evaluate using `trec_eval`.


## Reviews

+ Documentation reviewed at commit [xxxxxxx](https://github.com/osirrc/anserini-docker/commit/xxxxx) (mm/dd/yyyy) by [foo](https://github.com/foo/)
