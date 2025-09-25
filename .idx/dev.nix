{ pkgs, ... }: {
  # Use the latest nixpkgs channel
  channel = "unstable";

  # Packages installed inside the Firebase Studio workspace
  packages = with pkgs; [
    # Core development tools
    git
    unzip
    openssh
    sudo

    # Latest Python + pip
    python3Full
    python3Packages.pip

    # Virtualization & disk utilities
    qemu
    qemu_kvm
    cdrkit

    # Cloud utilities
    cloud-utils
  ];

  # Environment variables for the workspace
  env = {
    EDITOR = "nano"; # default editor
    # PYTHONPATH = "$PWD"; # uncomment if you want Python to use current dir
  };

  idx = {
    # Extensions from Open VSX
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    workspace = {
      # Runs once when the workspace is first created
      onCreate = {
        # Install latest Firebase CLI globally
        run = "npm install -g firebase-tools";
        # Upgrade pip + install virtualenv
        run = "pip install --upgrade pip virtualenv";
        # Check QEMU version
        run = "qemu-system-x86_64 --version";
      };

      # Runs every time the workspace is (re)started
      onStart = {
        # Verify Firebase CLI is available
        run = "firebase --version || echo 'Firebase CLI not installed'";
        # Check Python version
        run = "python3 --version";
      };
    };

    # Disable previews for performance unless needed
    previews.enable = false;
  };
}
