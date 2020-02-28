cwlVersion: v1.0
class: CommandLineTool
id: sambamba_merge_anylist
requirements:
  - class: ShellCommandRequirement
  - class: ResourceRequirement
    ramMin: 2024
    coresMin: 36
  - class: DockerRequirement
    dockerPull: 'images.sbgenomics.com/bogdang/sambamba:0.6.3'
  - class: InlineJavascriptRequirement
baseCommand: []
arguments:
  - position: 0
    shellQuote: false
    valueFrom: |-
      bams="${
        var flatin = [].concat.apply([],inputs.bams);
        var arr = [];
        for (var i=0; i<flatin.length; i++)
          arr = arr.concat(flatin[i].path)
        return(arr.join(' '))
      }"
      /opt/sambamba_0.6.3/sambamba_v0.6.3 merge -t 36 $(inputs.base_file_name).aligned.duplicates_marked.unsorted.bam $bams && rm $bams
inputs:
  bams:
    type: Any[]
    doc: "Input will be a combination of File[] and deeply nested File[]. Any[] is flexible enough to accomodate the different types."
  base_file_name: string
outputs:
  merged_bam:
    type: File
    outputBinding:
      glob: '*.bam'
    secondaryFiles: [.bai, ^.bai]
    format: BAM
