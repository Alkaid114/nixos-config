{pkgs,...}:
{
  home.packages = with pkgs;[
    (vscode.override {
      commandLineArgs = [
        "--wayland-text-input-version=3"
      ];
    })
  ];
}
