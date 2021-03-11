#/usr/bin/perl -w
use Bio::SeqIO;
use Bio::Seq;
$seqin = Bio::SeqIO->new( -format => 'EMBL' , -file => 'myfile.dat');
$seqout= Bio::SeqIO->new( -format => 'Fasta', -file => '>output.fa');

while((my $seqobj = $seqin->next_seq())) {
      print "Seen sequence ",$seqobj->display_id,", start of seq ",
            substr($seqobj->seq,1,10),"\n";
      if( $seqobj->alphabet eq 'dna') {
            $rev = $seqobj->revcom;
            $id  = $seqobj->display_id();
            $id  = "$id.rev";
            $rev->display_id($id);
            $seqout->write_seq($rev);
      }

      foreach $feat ( $seqobj->get_SeqFeatures() ) {
           if( $feat->primary_tag eq 'exon' ) {
              print STDOUT "Location ",$feat->start,":",
                    $feat->end," GFF[",$feat->gff_string,"]\n";
           }
      }
  }