use gravity::run;

fn main() {
    if let Err(error) = run() {
        eprintln!("failed to start gravity: {error:#}");
        eprintln!(
            "hint: if you're on Linux and Wayland startup fails, try `WINIT_UNIX_BACKEND=x11 cargo run`"
        );
        std::process::exit(1);
    }
}
