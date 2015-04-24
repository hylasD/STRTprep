##
## Step 3g - fluctuated genes
##

file 'out/byGene/fluctuation.txt.gz' => 'out/byGene/nreads.RData' do |t|
  tmp = 'tmp/byGene/nreads.RData'
  if (!File.exist?(t.name) ||
      !File.exist?(tmp) ||
      `md5sum #{t.source} #{tmp} | gcut -d ' ' -f 1 | guniq | gwc -l`.to_i != 1)
    sh "R --vanilla --quiet --args #{DEFAULTS['FLUCTUATION']} #{t.name.pathmap('%d')} < bin/_step3g_fluctuation.R > #{t.name}.log 2>&1"
    sh "cp -p #{t.source} #{tmp}"
  else
    puts "... skipped #{t.name}, since the qualified samples were identical with the previous run"
    sh "touch #{t.name}"
  end
end
