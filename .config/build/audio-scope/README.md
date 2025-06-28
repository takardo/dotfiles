# Visify - Real-Time Audio Oscilloscope

Visify is a real-time audio oscilloscope written in C that visualises live audio input as a waveform.

## Features

- Captures audio input in real-time using **PortAudio**.
- Displays a waveform using **SDL2**.
- Supports **Fedora**, **Ubuntu**, **OpenSuse** and **Arch Linux** (Windows version coming soon!).

## Compatibility

| Operating System | Status         |
| ---------------- | -------------- |
| Fedora           | ✅ Supported   |
| Debian           | ✅ Supported   |
| Ubuntu           | ✅ Supported   |
| Arch Linux       | ✅ Supported   |
| Open Suse        | ✅ Supported   |
| Windows          | 🚧 Coming soon |

## Installation
Run the install script:
```bash
bash install.sh
```
OR
1. Clone the repository:

   ```bash
   git clone https://github.com/syszelj9/visify.git
   cd visify
   ```

2. Install the dependencies:
Fedora
    ```
    sudo dnf update -y
    ```
    ```
    sudo dnf install -y portaudio-devel SDL2-devel gcc make
    ```
  Arch
  ```
  sudo pacamn -Syu
  ```
  ```
  sudo pacman -Sy --noconfirm portaudio sdl2 gcc make
  ```
  Ubuntu/Debian
  ```
  sudo apt update -y
  ```
  ```
  sudo apt install -y libportaudio2 libportaudiocpp0 portaudio19-dev libsdl2-dev gcc make
  ```
  Open Suse
  ```
  sudo zypper in libportaudio2 portaudio-devel sdl2-compat-devel gcc make
  ```
## Usage

After installation, run the program with:
```bash
./visify
```
If you did not use the install script, do this:
```
gcc source.c -o visify -lportaudio -lSDL2 -lm
```

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests.

## License

This project is licensed under the GNU GPL 3.0 License.

