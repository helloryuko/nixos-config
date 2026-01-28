{
  autoPatchelfHook,
  copyDesktopItems,
  dbus,
  fetchurl,
  fontconfig,
  freetype,
  lib,
  libGLU,
  libxkbcommon,
  makeDesktopItem,
  stdenv,
  unzip,
  wayland,
  xcbutilimage,
  xcbutilkeysyms,
  xcbutilrenderutil,
  xcbutilwm,
  libxml2,
  python3
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "binaryninja";
  version = "5.2.8614";

  src = fetchurl {
    url = "https://bogus.com";
    name = "binaryninja_linux_stable_personal.zip";
    hash = "sha256-NizyjcjKt8JejBouhczH+i9s4LgFirTUY2MC1Vl8eTQ=";
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/Vector35/binaryninja-api/448f40be71dffa86a6581c3696627ccc1bdf74f2/docs/img/logo.png";
    hash = "sha256-TzGAAefTknnOBj70IHe64D6VwRKqIDpL4+o9kTw0Mn4=";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "com.vector35.binaryninja";
      desktopName = "Binary Ninja Personal";
      comment = "A Reverse Engineering Platform";
      exec = "binaryninja";
      icon = "binaryninja";
      mimeTypes = [
        "application/x-binaryninja"
        "x-scheme-handler/binaryninja"
      ];
      categories = [ "Utility" ];
    })
  ];

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
    copyDesktopItems
  ];

  buildInputs = [
    dbus
    fontconfig
    freetype
    libGLU
    libxkbcommon
    stdenv.cc.cc.lib
    wayland
    xcbutilimage
    xcbutilkeysyms
    xcbutilrenderutil
    xcbutilwm
  ];

  # PySide6 binary dependencies
  autoPatchelfIgnoreMissingDeps = ["libQt6PrintSupport.so.6" "libQt6ShaderTools.so.6" "libQt6QuickVectorImageGenerator.so.6" "libQt6Quick.so.6" "libQt6Qml.so.6"];

  warn = if builtins.pathExists ./ill_take_it.py then [] else builtins.trace "Secret python script not found ${toString ./.}... @_@" [];

  preFixup = ''
    # Fix libxml2 breakage. See https://github.com/NixOS/nixpkgs/pull/396195#issuecomment-2881757108
    mkdir -p "$out/lib"
    ln -s "${lib.getLib libxml2}/lib/libxml2.so" "$out/lib/libxml2.so.2"
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -R ./ $out/

    mkdir $out/bin
    ln -s $out/binaryninja $out/bin/binaryninja

    pushd $out
    ${
      if builtins.pathExists ./ill_take_it.py then
        "${python3}/bin/python3 ${./ill_take_it.py}"
      else ""
    }
    popd

    install -Dm644 ${finalAttrs.icon} $out/share/icons/hicolor/256x256/apps/binaryninja.png

    runHook postInstall
  '';

  meta = {
    changelog = "https://binary.ninja/changelog/#${
      lib.replaceStrings [ "." ] [ "-" ] finalAttrs.version
    }";
    description = "Interactive decompiler, disassembler, debugger";
    homepage = "https://binary.ninja/";
    license = {
      fullName = "Binary Ninja Personal Software License";
      url = "https://docs.binary.ninja/about/license.html#free-license";
      free = false;
    };
    mainProgram = "binaryninja";
    maintainers = with lib.maintainers; [ scoder12 ];
    platforms = [ "x86_64-linux" ];
  };
})
