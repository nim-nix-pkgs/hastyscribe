{
  description = ''Self-contained markdown compiler generating self-contained HTML documents'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-hastyscribe-v1_1_2.flake = false;
  inputs.src-hastyscribe-v1_1_2.owner = "h3rald";
  inputs.src-hastyscribe-v1_1_2.ref   = "refs/tags/v1.1.2";
  inputs.src-hastyscribe-v1_1_2.repo  = "hastyscribe";
  inputs.src-hastyscribe-v1_1_2.type  = "github";
  
  inputs."nimrod".owner = "nim-nix-pkgs";
  inputs."nimrod".ref   = "master";
  inputs."nimrod".repo  = "nimrod";
  inputs."nimrod".type  = "github";
  inputs."nimrod".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimrod".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-hastyscribe-v1_1_2"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-hastyscribe-v1_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}