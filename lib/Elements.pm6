unit module Elements;

subset Element of Str is export
  where * ∈ < H He Li Be B C N O F Ne Na Mg Al Si P S Cl
              Ar K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge
              As Se Br Kr Rb Sr Y Zr Nb Mo Tc Ru Rh Pd
              Ag Cd In Sn Sb Te I Xe Cs Ba La Ce Pr Nd
              Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu  Hf Ta W
              Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn Fr Ra
              Ac Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No
              Lr Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc
              Lv Ts Og X >;

my constant $NUMBER-OF-ATOMS is export = 118;

my constant @EXTENDED-PERIODIC-TABLE is export
  = ( < H X X X X X X X X X X X X X X X X He >
    , < Li Be X X X X X X X X X X B C N O F Ne >
    , < Na Mg X X X X X X X X X X Al Si P S Cl Ar >
    , < K Ca Sc Ti V Cr Mn Fe Co Ni Cu Zn Ga Ge As Se Br Kr >
    , < Rb Sr Y Zr Nb Mo Tc Ru Rh Pd Ag Cd In Sn Sb Te I Xe >
    , < Cs Ba X Hf Ta W Re Os Ir Pt Au Hg Tl Pb Bi Po At Rn >
    , < Fr Ra X Rf Db Sg Bh Hs Mt Ds Rg Cn Nh Fl Mc Lv Ts Og >
    , (<X>,)
    , < X X La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb Lu >
    , < X X Th Pa U Np Pu Am Cm Bk Cf Es Fm Md No Lr >
    )
    ;
