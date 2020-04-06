#!/usr/bin/env raku

use v6;
use lib 'lib';
use GTK::Simple;
use GTK::Simple::App;

my constant @EXTENDED-PERIODIC-TABLE =
(  <  H   X   X   X   X   X   X   X   X   X   X   X   X   X   X   X   X   He  >
,  <  Li  Be  X   X   X   X   X   X   X   X   X   X   B   C   N   O   F   Ne  >
,  <  Na  Mg  X   X   X   X   X   X   X   X   X   X   Al  Si  P   S   Cl  Ar  >
,  <  K   Ca  Sc  Ti  V   Cr  Mn  Fe  Co  Ni  Cu  Zn  Ga  Ge  As  Se  Br  Kr  >
,  <  Rb  Sr  Y   Zr  Nb  Mo  Tc  Ru  Rh  Pd  Ag  Cd  In  Sn  Sb  Te  I   Xe  >
,  <  Cs  Ba  X   Hf  Ta  W   Re  Os  Ir  Pt  Au  Hg  Tl  Pb  Bi  Po  At  Rn  >
,  <  Fr  Ra  X   Rf  Db  Sg  Bh  Hs  Mt  Ds  Rg  Cn  Nh  Fl  Mc  Lv  Ts  Og  >
,  <  X   X   X                                                               >
,  <  X   X   La  Ce  Pr  Nd  Pm  Sm  Eu  Gd  Tb  Dy  Ho  Er  Tm  Yb  Lu  X   >
,  <  X   X   Ac  Th  Pa  U   Np  Pu  Am  Cm  Bk  Cf  Es  Fm  Md  No  Lr  X   >
)
;

my constant @ALL-ATOMS = @EXTENDED-PERIODIC-TABLE.flat.unique;

subset Element of Str where * ∈ @ALL-ATOMS ;

my GTK::Simple::App $app .= new(title => "Periodic table trainer");

my $PROGRESS = GTK::Simple::ProgressBar.new;

my %ELEMENT-ENTRIES;

multi sub element-to-box (Element $e, Int $row, Int $col) of Pair {
  {
    %ELEMENT-ENTRIES{$e} = hash label => GTK::Simple::MarkUpLabel.new(text=>"")
                              , entry => $_
                              ;

    .map: {.width-chars = 3};
    .changed.tap: {

      if $e eq .text {
        %ELEMENT-ENTRIES{$e}<label>.text = qq!<span foreground="green">YES</span>!;
        $PROGRESS.fraction += 1/+@ALL-ATOMS;
      } else {
        %ELEMENT-ENTRIES{$e}<label>.text = qq!<span foreground="red">NO</span>!;
      }
    };
    [$row, $col, 1, 1] =>
                      GTK::Simple::VBox.new($_, %ELEMENT-ENTRIES{$e}<label>)
  } given GTK::Simple::Entry.new(text => "")
}

sub MAIN {

  my @periodic-table-cells = gather {
    my Int $i = -1;
    for @EXTENDED-PERIODIC-TABLE -> @row {
        my Int $j = -1;
        $i++;
      for @row -> $el {
        $j++;
        take element-to-box $el, $j, $i if not $el eq <X>
      }
    }
  }

  my GTK::Simple::Grid $a .= new(
    |@periodic-table-cells
  );

  my $vbox = GTK::Simple::VBox.new(
    $a, $PROGRESS
  );


  {
    .set-content($vbox);
    .border-width = 20;
    .run;
  } given $app;
}
