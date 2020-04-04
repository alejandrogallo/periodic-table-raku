#!/usr/bin/env perl6

use v6;
use lib 'lib';
use GTK::Simple;
use GTK::Simple::App;
use Elements;

my GTK::Simple::App $app .= new(title => "Grid layouts!");

my $progress = GTK::Simple::ProgressBar.new;

multi sub element-to-box (Element $e, Int $row, Int $col) of Pair {
  {
    .map: {.width-chars = 3};
    .changed.tap: {
      if $e eq .text {
        $progress.fraction += 1/$NUMBER-OF-ATOMS;
        .signal-supply("key-press-event")
      }
    };
    [$row, $col, 1, 1] => $_
  } given GTK::Simple::Entry.new(text => "")
}

my @x-stuff = gather {
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
  |@x-stuff
);

my $vbox = GTK::Simple::VBox.new(
  $a, $progress
);

$app.set-content($vbox);
$app.border-width = 20;

$app.run;
