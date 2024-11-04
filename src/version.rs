pub const VERSION: &str = "v1.1.0";
pub const GITHUB_LINK: &str = "https://github.com/ATDSviluppo/trak-automatic-printer";
pub const CHANGELOG: &str = "Introduced 'build.sh' and 'prepare.sh' scripts to automate the build process using 'OpenSSL 1.1.1w' and the 'MUSL libc' instead of 'glibc'.";

pub fn print_version_info() {
    println!("Version: {}", VERSION);
    println!("GitHub Repository: {}", GITHUB_LINK);
    println!("Changelog: {}", CHANGELOG);
}
