The line PrefersNonDefaultGPU=true is part of the FreeDesktop.org standard for application launchers (.desktop files).

    What it's for: Its primary purpose is for systems with hybrid graphics, like a laptop that has both a power-saving integrated GPU (e.g., Intel) and a high-performance discrete GPU (e.g., AMD or NVIDIA). Adding PrefersNonDefaultGPU=true tells the desktop environment, "If you can, please run this application on the powerful, non-default GPU."

    The Unintended Consequence: On your desktop system, you likely have only one primary AMD GPU. However, the KDE Plasma desktop environment still sees this flag and tries to honor it. To do so, it likely forces a specific launch method or sets an environment variable (like DRI_PRIME=1) intended for switching GPUs. This special launch path, designed for hybrid graphics, created an incompatibility with Steam's web renderer (steamwebhelper) and your radv driver, leading to the segmentation fault.

    Why the Terminal Worked: When you run steam from the command line, the system does not read the steam.desktop file. It simply runs the executable. Therefore, the problematic PrefersNonDefaultGPU flag was never processed, and Steam launched in a standard environment that was perfectly compatible with your hardware.

By removing that line, you are telling the desktop environment to stop using the special "high-performance GPU" launch path and to just run Steam normally, which resolves the crash.

How to use the script:

    Download the script

    Open a terminal and navigate to where you saved the file.

    Make the script executable with the following command:
```bash
chmod +x fix_steam.sh

Run the script:
./fix_steam.sh
```

It will print its progress and let you know when the fix is complete. After running it, you should be able to launch Steam from your application menu without any issues.
