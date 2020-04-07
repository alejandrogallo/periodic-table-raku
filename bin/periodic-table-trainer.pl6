#!/usr/bin/env raku

use v6;
use GTK::Simple;
use GTK::Simple::App;

my %ENTRIES; # will have all gtk widgets for every element
my $APP = GTK::Simple::App.new(title => "Periodic table trainer");
my $PROGRESS = GTK::Simple::ProgressBar.new; # the progress bar

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


multi sub element-to-box (Element $e, Int $row, Int $col) of Pair {
  {
    %ENTRIES{$e} = hash label => GTK::Simple::MarkUpLabel.new(text=>"")
                              , entry => $_
                              ;

    .map: {.width-chars = 3}; # set entry to 3 chars wide
    .changed.tap: {           # what to do if the input changed
      if $e eq .text {
        %ENTRIES{$e}<label>.text = qq!<span foreground="green">YES</span>!;
        $PROGRESS.fraction += 1/+@ALL-ATOMS;
      } else {
        %ENTRIES{$e}<label>.text = qq!<span foreground="red">NO</span>!;
      }
    };
    [$row, $col, 1, 1] => GTK::Simple::VBox.new($_, %ENTRIES{$e}<label>)
  } given GTK::Simple::Entry.new(text => "")
}


sub MAIN {

  my @periodic-table-cells = gather {
    for 1..* Z @EXTENDED-PERIODIC-TABLE -> ($i, @row) {
      for 1..* Z @row -> ($j, $el) {
        take element-to-box $el, $j, $i if not $el eq <X>
      }
    }
  }

  my GTK::Simple::Grid $periodic-table-grid .= new: |@periodic-table-cells;
  my GTK::Simple::VBox $vbox .= new: $periodic-table-grid, $PROGRESS;

  {
    .set-content($vbox);
    .border-width = 20;
    .run;
  } given $APP;

}
