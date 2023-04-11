require "sam"
require "file_utils"
require "colorize"
require "totem"

desc "Sets up an airgapped tarball"
task "airgapped",  do  |t, args|
  t.invoke("install_kubescape")
  #./cnf-testsuite setup --offline=./airgapped.tar.gz
  #./cnf-testsuite airgapped -o ~/airgapped.tar.gz
  #./cnf-testsuite offline of=~/airgapped.tar.gz
  #./cnf-testsuite offline output-file=~/mydir/airgapped.tar.gz
  output_file = args.named["output-file"].as(String) if args.named["output-file"]?
    output_file = args.named["of"].as(String) if args.named["of"]?
  if output_file && !output_file.empty?
    # todo check if file exists
    CNFManager::CNFAirGap.generate(output_file)
  else
    CNFManager::CNFAirGap.generate()
  end
  stdout_success "Airgap setup complete"
end

desc "Extracts an airgapped tarball"
task "extract",  do  |_, args|
  input_file = args.named["input-file"].as(String) if args.named["input-file"]?
    input_file = args.named["if"].as(String) if args.named["of"]?
  if input_file && !input_file.empty?
      AirGap.extract(input_file)
  else
    AirGap.extract()
  end
end

