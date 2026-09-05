{ pkgs }:

let
  version = "10.0.26100.1742-4";
  # Windows 11 24H2 Enterprise evaluation ISO
  iso = pkgs.fetchurl {
    url = "https://software-static.download.prss.microsoft.com/dbazure/888969d5-f34g-4e03-ac9d-1f9786c66749/26100.1742.240906-0331.ge_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso";
    hash = "sha256-dVqQ1D6CanS54ZMqNHiLiY4CgnJDm3d+VZPe6NU2Iq4=";
  };
in
pkgs.runCommand "ttf-ms-win11-auto-${version}"
  {
    outputHash = "sha256-whTRCB0TcvSsCXKJCLA7eEjZz6whQudmkXrxrOxzDrg=";
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    nativeBuildInputs = [
      pkgs.p7zip
      pkgs.wimlib
    ];
    meta = with pkgs.lib; {
      description = "Microsoft Windows 11 core fonts, extracted from the official ISO";
      license = licenses.unfree;
      platforms = platforms.all;
    };
  }
  ''
    7z e -y -o$TMPDIR ${iso} sources/install.wim
    mkdir -p $out/share/fonts/truetype
    wimextract $TMPDIR/install.wim 1 Windows/Fonts \
      --dest-dir=$TMPDIR/wim --no-acls --no-attributes
    cd $TMPDIR/wim/Fonts
    cp \
      arialbd.ttf arialbi.ttf ariali.ttf arial.ttf ariblk.ttf \
      bahnschrift.ttf calibrib.ttf calibrii.ttf calibrili.ttf \
      calibril.ttf calibri.ttf calibriz.ttf cambriab.ttf cambriai.ttf \
      cambria.ttc cambriaz.ttf Candarab.ttf Candarai.ttf Candarali.ttf \
      Candaral.ttf Candara.ttf Candaraz.ttf comicbd.ttf comici.ttf \
      comic.ttf comicz.ttf consolab.ttf consolai.ttf consola.ttf \
      consolaz.ttf constanb.ttf constani.ttf constan.ttf constanz.ttf \
      corbelb.ttf corbeli.ttf corbelli.ttf corbell.ttf corbel.ttf \
      corbelz.ttf courbd.ttf courbi.ttf couri.ttf cour.ttf \
      framdit.ttf framd.ttf Gabriola.ttf georgiab.ttf georgiai.ttf \
      georgia.ttf georgiaz.ttf impact.ttf Inkfree.ttf l_10646.ttf \
      lucon.ttf marlett.ttf micross.ttf palabi.ttf palab.ttf \
      palai.ttf pala.ttf segmdl2.ttf SegoeIcons.ttf segoeprb.ttf \
      segoepr.ttf segoescb.ttf segoesc.ttf segoeuib.ttf segoeuii.ttf \
      segoeuil.ttf segoeuisl.ttf segoeui.ttf segoeuiz.ttf seguibli.ttf \
      seguibl.ttf seguiemj.ttf seguihis.ttf seguili.ttf seguisbi.ttf \
      seguisb.ttf seguisli.ttf seguisym.ttf SegUIVar.ttf \
      SitkaVF-Italic.ttf SitkaVF.ttf sylfaen.ttf symbol.ttf \
      tahomabd.ttf tahoma.ttf timesbd.ttf timesbi.ttf timesi.ttf \
      times.ttf trebucbd.ttf trebucbi.ttf trebucit.ttf trebuc.ttf \
      verdanab.ttf verdanai.ttf verdana.ttf verdanaz.ttf webdings.ttf \
      wingding.ttf \
      $out/share/fonts/truetype/
  ''
