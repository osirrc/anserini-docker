# Anserini OSIRRC Docker Image

[![Build Status](https://travis-ci.com/osirrc/anserini-docker.svg?branch=master)](https://travis-ci.com/osirrc/anserini-docker)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3240584.svg)](https://doi.org/10.5281/zenodo.3240584)


[**Ryan Clancy**](https://github.com/r-clancy/) and [**Jimmy Lin**](https://github.com/lintool/)

This is the docker image for the [Anserini](http://anserini.io/) toolkit (v0.5.0) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/anserini
) has been tested with the jig at commit [ca31987](https://github.com/osirrc/jig/commit/ca3198704795f2b6de8b78ed7a66bbdf1dccadb1) (6/5/2019).

+ Supported test collections: `core17`, `core18`, `cw09b`, `cw12b`, `gov2`, `robust04`
+ Supported hooks: `init`, `index`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare \
  --repo osirrc2019/anserini \
  --tag v0.1.0 \
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

The following numbers should be able to be re-produced using the scripts provided in the [bin](bin) directory.

### core17

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2017 Common Core Track Topics](https://trec.nist.gov/data/core/core_nist.txt)| 0.2087    | 0.2823    | 0.2787    | 0.2032    | 0.2606    | 0.2613    |

### core18

MAP                                     | BM25      | +RM3  | +Ax   | QL        | +RM3    | +Ax     |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2018 Common Core Track Topics](https://trec.nist.gov/data/core/topics2018.txt)| 0.2495    | 0.3136    | 0.2920    | 0.2526    | 0.3073    | 0.2966    |

### cw09b

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2010 Web Track: Topics 51-100](http://trec.nist.gov/data/web/10/wt2010-topics.xml)| 0.1126    | 0.0933    | 0.0928    | 0.1060    | 0.1019    | 0.1086    |
[TREC 2011 Web Track: Topics 101-150](http://trec.nist.gov/data/web/11/full-topics.xml)| 0.1094    | 0.1081    | 0.0974    | 0.0958    | 0.0837    | 0.0879    |
[TREC 2012 Web Track: Topics 151-200](http://trec.nist.gov/data/web/12/full-topics.xml)| 0.1106    | 0.1107    | 0.1315    | 0.1069    | 0.1059    | 0.1212    |

### cw12b

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3    | +Ax     |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2013 Web Track: Topics 201-250](http://trec.nist.gov/data/web2013.html)| 0.0468    | 0.0412    | 0.0435    | 0.0397    | 0.0322    | 0.0359    |
[TREC 2014 Web Track: Topics 251-300](http://trec.nist.gov/data/web2014.html)| 0.0224    | 0.0210    | 0.0180    | 0.0235    | 0.0203    | 0.0186    |

### gov2

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2004 Terabyte Track: Topics 701-750](http://trec.nist.gov/data/terabyte04.html)| 0.2689    | 0.2844    | 0.2665    | 0.2681    | 0.2708    | 0.2666    |
[TREC 2005 Terabyte Track: Topics 751-800](http://trec.nist.gov/data/terabyte05.html)| 0.3390    | 0.3820    | 0.3664    | 0.3303    | 0.3559    | 0.3646    |
[TREC 2006 Terabyte Track: Topics 801-850](http://trec.nist.gov/data/terabyte06.html)| 0.3080    | 0.3377    | 0.3069    | 0.2996    | 0.3154    | 0.3084    |

### robust04

MAP                                     | BM25      | +RM3      | +Ax       | QL        | +RM3      | +Ax       |
:---------------------------------------|-----------|-----------|-----------|-----------|-----------|-----------|
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz)| 0.2531    | 0.2903    | 0.2895    | 0.2467    | 0.2747    | 0.2774    |

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

+ Documentation reviewed at commit [68f8291](https://github.com/osirrc/anserini-docker/commit/68f82912f7cc791e8d74877033a5f035d8b95035) (06/06/2019) by [Chris Kamphuis](https://github.com/chriskamphuis/)
