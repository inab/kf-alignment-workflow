cwlVersion: v1.0
class: CommandLineTool
id: samtools_bam_to_cram_dev
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4000
  - class: DockerRequirement
    dockerPull: 'kfdrc/samtools:1.8-dev'
baseCommand: [samtools, view]
arguments:
  - position: 1
    shellQuote: false
    valueFrom: >-
      -C -T $(inputs.reference.path) -@ 35 -o $(inputs.output_basename).cram $(inputs.input_bam.path)
      && samtools index -@ 35 $(inputs.output_basename).cram
inputs:
  reference: {type: File, secondaryFiles: [.fai]}
  input_bam: {type: File, secondaryFiles: [^.bai]}
  output_basename: string
outputs:
  output:
    type: File
    outputBinding:
      glob: '*.cram'
    secondaryFiles: [.crai]
