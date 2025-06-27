{config, pkgs, ...}:

{
environment.systemPackages = with pkgs; [

# === Development Tools ===
gh
libgcc
clang
nodejs_20
gnumake42
openssl
pnpm
watchexec
direnv
python3
# === LSP servers ===
lua-language-server
stylua
black

];

environment.variables = {
  cc = "gcc";
};

}
