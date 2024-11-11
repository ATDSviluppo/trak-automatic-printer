pub const VERSION: &str = "v1.1.1";
pub const GITHUB_LINK: &str = "https://github.com/ATDSviluppo/trak-automatic-printer";
pub const CHANGELOG: &str = "Added pipeline to build in older glibc versions.";

pub fn print_version_info() {
    println!("Version: {}", VERSION);
    println!("GitHub Repository: {}", GITHUB_LINK);
    println!("Changelog: {}", CHANGELOG);
}
