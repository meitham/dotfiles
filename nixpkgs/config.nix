{ # ...

  packageOverrides = pkgs: with pkgs; {
    myEnv = python37.withPackages (ps: with ps; [ numpy toolz ]);
  };
}
