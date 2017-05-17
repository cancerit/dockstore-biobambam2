#!/usr/bin/env cwl-runner

class: CommandLineTool

id: "biobambam2-bamtofastq"

label: "biobambam2-bamtofastq"

cwlVersion: v1.0

doc: |
    ![build_status](https://quay.io/repository/wtsicgp/dockstore-biobambam2/status)
    A wrapper for biobambam2 bamtofastq tool. See the [dockstore-biobambam2](https://github.com/cancerit/dockstore-biobambam2) website for more information about this wrapper.
    For queries relating to the underlying software see [biobambam2](https://github.com/gt1/biobambam2).

    NOTE: Please ensure you use file extensions that match the following so that outputs are captured:
      For FASTQ:
        .fq
        .fq.gz
      For FASTA:
        .fa
        .fa.gz

    Usage at time of writing:
      biobambam2 is distributed under version 3 of the GNU General Public License.

      Key=Value pairs:

      F=<[stdout]>                                : matched pairs first mates (file name, NO path)
      F2=<[stdout]>                               : matched pairs second mates (file name, NO path)
      S=<[stdout]>                                : single end (file name, NO path)
      O=<[stdout]>                                : unmatched pairs first mates (file name, NO path)
      O2=<[stdout]>                               : unmatched pairs second mates (file name, NO path)
      collate=<[1]>                               : collate pairs
      combs=<[0]>                                 : print some counts after collation based processing
      filename=<[stdin]>                          : input filename (default: read file from standard input)
      inputformat=<[bam]>                         : input format: cram, bam or sam
      reference=<[]>                              : name of reference FastA in case of inputformat=cram
      ranges=<[]>                                 : input ranges (bam and cram input only, default: read complete file)
      exclude=<[SECONDARY,SUPPLEMENTARY]>         : exclude alignments matching any of the given flags
      disablevalidation=<[0]>                     : disable validation of input data
      colhlog=<[18]>                              : base 2 logarithm of hash table size used for collation
      colsbs=<[33554432]>                         : size of hash table overflow list in bytes
      gz=<[0]>                                    : compress output streams in gzip format (default: 0)
      level=<[-1]>                                : compression setting if gz=1 (-1=zlib default,0=uncompressed,1=fast,9=best)
      fasta=<[0]>                                 : output FastA instead of FastQ
      inputbuffersize=<[-1]>                      : size of input buffer
      outputperreadgroup=<[0]>                    : split output per read group (for collate=1 only)
      outputperreadgroupsuffixF=<[_1.fq]>         : suffix for F category when outputperreadgroup=1 (.gz not added when gz=1)
      outputperreadgroupsuffixF2=<[_2.fq]>        : suffix for F2 category when outputperreadgroup=1 (.gz not added when gz=1)
      outputperreadgroupsuffixO=<[_o1.fq]>        : suffix for O category when outputperreadgroup=1 (.gz not added when gz=1)
      outputperreadgroupsuffixO2=<[_o2.fq]>       : suffix for O2 category when outputperreadgroup=1 (.gz not added when gz=1)
      outputperreadgroupsuffixS=<[_s.fq]>         : suffix for S category when outputperreadgroup=1 (.gz not added when gz=1)
      tryoq=<[0]>                                 : use OQ field instead of quality field if present (collate={0,1} only)
      split=<[0]>                                 : split named output files into chunks of this amount of reads (0: do not split)
      splitprefix=<[bamtofastq_split]>            : file name prefix if collate=0 and split>0 (NO path elements)
      tags=<[]>                                   : list of aux tags to be copied (default: do not copy any aux fields)
      outputperreadgrouprgsm=<[0]>                : add read group field SM ahead of read group id when outputperreadgroup=1 (for collate=1 only)
      outputperreadgroupprefix=<[]>               : prefix added in front of file names if outputperreadgroup=1 (for collate=1 only) (NO path elements)

      Alignment flags: PAIRED,PROPER_PAIR,UNMAP,MUNMAP,REVERSE,MREVERSE,READ1,READ2,SECONDARY,QCFAIL,DUP,SUPPLEMENTARY

    Some options are not available within the wrapper:
      outputdir=<>                                : directory for output if outputperreadgroup=1 (default: current directory)
      T=<[bamtofastq_ea1e73415eba_15_1495014816]> : temporary file name

dct:creator:
  "@id": "http://orcid.org/0000-0002-5634-1539"
  foaf:name: Keiran M Raine
  foaf:mbox: "keiranmraine@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/wtsicgp/dockstore-biobambam2:develop"

hints:
  - class: ResourceRequirement
    coresMin: 1 # works but long, 24 recommended
    ramMin: 1000
    outdirMin: 1000 # completely dependent on input data

inputs:
  F:
    type: string?
    doc: "matched pairs first mates"
    inputBinding:
      prefix: F=
      separate: false

  F2:
    type: string?
    doc: "matched pairs second mates"
    inputBinding:
      prefix: F2=
      separate: false

  S:
    type: string?
    doc: "single end"
    inputBinding:
      prefix: S=
      separate: false

  O:
    type: string?
    doc: "unmatched pairs first mates"
    inputBinding:
      prefix: O=
      separate: false

  O2:
    type: string?
    doc: "unmatched pairs second mates"
    inputBinding:
      prefix: O2=
      separate: false

  collate:
    type: int?
    doc: "collate pairs"
    default: 1
    inputBinding:
      prefix: collate=
      separate: false

  combs:
    type: int?
    doc: "collate pairs"
    default: 0
    inputBinding:
      prefix: combs=
      separate: false

  filename:
    type: File
    doc: "input filename"
    streamable: true
    inputBinding:
      prefix: filename=
      separate: false

  inputformat:
    type: string?
    doc: "input format: cram, bam or sam [bam]"
    default: bam
    inputBinding:
      prefix: inputformat=
      separate: false

  reference:
    type: File?
    doc: "name of reference FastA in case of inputformat=cram"
    inputBinding:
      prefix: reference=
      separate: false

  ranges:
    type: string?
    doc: "input ranges (bam and cram input only, default: read complete file)"
    inputBinding:
      prefix: ranges=
      separate: false

  exclude:
    type: string?
    doc: "exclude alignments matching any of the given flags [SECONDARY,SUPPLEMENTARY]"
    default: SECONDARY,SUPPLEMENTARY
    inputBinding:
      prefix: exclude=
      separate: false

  disablevalidation:
    type: int?
    doc: "disable validation of input data [0]"
    default: 0
    inputBinding:
      prefix: disablevalidation=
      separate: false

  colhlog:
    type: int?
    doc: "base 2 logarithm of hash table size used for collation [18]"
    default: 18
    inputBinding:
      prefix: colhlog=
      separate: false

  colsbs:
    type: int?
    doc: "size of hash table overflow list in bytes [33554432]"
    default: 33554432
    inputBinding:
      prefix: colsbs=
      separate: false

  T:
    type: string?
    doc: "temporary file name [bamtofastq_*]"
    inputBinding:
      prefix: exclude=
      separate: false

  gz:
    type: int?
    doc: "compress output streams in gzip format (default: 0)"
    default: 0
    inputBinding:
      prefix: gz=
      separate: false

  level:
    type: int?
    doc: "compression setting if gz=1 (-1=zlib default,0=uncompressed,1=fast,9=best)"
    default: -1
    inputBinding:
      prefix: level=
      separate: false

  fasta:
    type: int?
    doc: "output FastA instead of FastQ"
    default: 0
    inputBinding:
      prefix: fasta=
      separate: false

  inputbuffersize:
    type: int?
    doc: "size of input buffer"
    default: -1
    inputBinding:
      prefix: inputbuffersize=
      separate: false

  outputperreadgroup:
    type: int?
    doc: "split output per read group (for collate=1 only)"
    default: 0
    inputBinding:
      prefix: outputperreadgroup=
      separate: false

  outputperreadgroupsuffixF:
    type: string?
    doc: "suffix for F category when outputperreadgroup=1 [_1.fq]"
    inputBinding:
      prefix: outputperreadgroupsuffixF=
      separate: false

  outputperreadgroupsuffixF2:
    type: string?
    doc: "suffix for F2 category when outputperreadgroup=1 [_2.fq]"
    inputBinding:
      prefix: outputperreadgroupsuffixF2=
      separate: false

  outputperreadgroupsuffixO:
    type: string?
    doc: "suffix for O category when outputperreadgroup=1 [_o1.fq]"
    inputBinding:
      prefix: outputperreadgroupsuffixO=
      separate: false

  outputperreadgroupsuffixO2:
    type: string?
    doc: "suffix for O2 category when outputperreadgroup=1 [_o2.fq]"
    inputBinding:
      prefix: outputperreadgroupsuffixO2=
      separate: false

  outputperreadgroupsuffixS:
    type: string?
    doc: "suffix for S category when outputperreadgroup=1 [_s.fq]"
    inputBinding:
      prefix: outputperreadgroupsuffixS=
      separate: false

  tryoq:
    type: int?
    doc: "use OQ field instead of quality field if present (collate={0,1} only) [0]"
    default: 0
    inputBinding:
      prefix: tryoq=
      separate: false

  split:
    type: int?
    doc: "split named output files into chunks of this amount of reads (0: do not split)"
    default: 0
    inputBinding:
      prefix: split=
      separate: false

  splitprefix:
    type: string?
    doc: "file name prefix if collate=0 and split>0"
    inputBinding:
      prefix: splitprefix=
      separate: false

  tags:
    type: int?
    doc: "list of aux tags to be copied (default: do not copy any aux fields)"
    inputBinding:
      prefix: tags=
      separate: false

  outputperreadgrouprgsm:
    type: int?
    doc: "add read group field SM ahead of read group id when outputperreadgroup=1 (for collate=1 only)"
    default: 0
    inputBinding:
      prefix: outputperreadgrouprgsm=
      separate: false

  outputperreadgroupprefix:
    type: string?
    doc: "prefix added in front of file names if outputperreadgroup=1 (for collate=1 only)"
    inputBinding:
      prefix: outputperreadgroupprefix=
      separate: false

outputs:
  output:
    type: array
    items: File
    outputBinding:
      glob:
        - "*.fq"
        - "*.fq.gz"
        - "*.fa"
        - "*.fa.gz"

baseCommand: ["/opt/wtsi-cgp/bin/bamtofastq"]
