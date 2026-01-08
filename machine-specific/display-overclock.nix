{ pkgs, ... }:

let
  # Don't ask me how I got it :)
  edidB64 = "AP///////wA4cE0AAAAAADMdAQSlIhN4AmhQmFxYjigbUFQAAAABAQEBAQEBAQEBAQEBAQEBSauABHE4MkAwIDUA4A4RAAAakYqABHE4MkAwIDUA4A4RAAAaLiVqGEE4LUBYLEUAGg4RAAAeAjqAGHE4LUBYLEUA4A4RAAAeAKs=";
  output = "eDP-1";
  mode = "1920x1080@178";
in
{
  hardware.display = {
    edid.packages = [
      (pkgs.runCommand "edid-custom" {} ''
        mkdir -p "$out/lib/firmware/edid"
        base64 -d > "$out/lib/firmware/edid/cst.bin" <<'EOF'
        ${edidB64}
        EOF
      '')
    ];
    outputs.${output} = { edid = "cst.bin"; mode = mode; };
  };
}
