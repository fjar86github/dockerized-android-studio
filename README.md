# dockerized-android-studio
1. Modifikasi Dockerfile
Pastikan Dockerfile telah dimodifikasi untuk mendukung tampilan grafis (dummy display atau VNC), seperti yang dijelaskan sebelumnya. Jika belum, tambahkan ini ke Dockerfile untuk mendukung Xvfb (dummy display) atau VNC.

dockerfile
Copy code
# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    xvfb \
    x11vnc \
    && apt-get clean

# Optionally expose port for VNC
EXPOSE 5901
2. Build Docker Image
Setelah Dockerfile dimodifikasi, saatnya membangun image Docker kamu. Jalankan perintah berikut di terminal untuk build image:

bash
Copy code
docker build -t yourdockerhubusername/android-studio .
Ini akan membangun image baru berdasarkan Dockerfile yang telah kamu modifikasi.

3. Push Docker Image ke Docker Hub (Opsional)
Jika kamu ingin menyimpan image ini di Docker Hub, kamu perlu login terlebih dahulu, lalu push image-nya:

bash
Copy code
# Login to Docker Hub
docker login --username yourdockerhubusername

# Push the image
docker push yourdockerhubusername/android-studio
Jika tidak ada masalah dengan token atau akses, image akan berhasil dipush ke Docker Hub.

4. Jalankan Container
Sekarang, jalankan container dari image yang sudah kamu build.

Jika Menggunakan Xvfb (Dummy Display):
Jalankan container dengan virtual framebuffer (Xvfb):

bash
Copy code
docker run -it --name android-container yourdockerhubusername/android-studio
Setelah container berjalan, jalankan Xvfb dan Android Studio:

bash
Copy code
# Di dalam container:
Xvfb :0 -screen 0 1024x768x16 &  # Start dummy display
export DISPLAY=:0                 # Set display environment
./studio.sh                       # Start Android Studio
Ini akan menjalankan Android Studio di container tanpa GUI (headless mode).

Jika Menggunakan VNC (Akses Grafis via Remote):
Jika kamu menggunakan VNC untuk akses tampilan grafis, jalankan perintah berikut:

bash
Copy code
docker run -it -p 5901:5901 --name android-container yourdockerhubusername/android-studio
Di dalam container, jalankan VNC server dan Android Studio:

bash
Copy code
tightvncserver :1 -geometry 1280x800 -depth 16 -pixelformat rgb565
export DISPLAY=:1
./studio.sh
Setelah ini, kamu bisa mengakses Android Studio melalui VNC client di komputer lokal kamu.

5. Akses Android Studio via VNC (Jika Menggunakan VNC)
Untuk mengakses Android Studio yang berjalan di container, kamu perlu menggunakan VNC client. Di VNC client, masukkan alamat:

makefile
Copy code
localhost:5901
Kamu akan terhubung ke Android Studio melalui antarmuka grafis.

6. Running the Emulator in Headless Mode (Opsional)
Jika kamu tidak memerlukan GUI untuk emulator, kamu dapat menjalankan emulator dalam mode headless dengan perintah berikut di dalam container:

bash
Copy code
emulator -avd <AVD_NAME> -no-window -no-audio
Kesimpulan
Modifikasi Dockerfile dengan mendukung Xvfb atau VNC.
Build image Docker menggunakan perintah docker build.
Push ke Docker Hub (jika perlu).
Jalankan container dan sesuaikan perintah dengan metode yang kamu gunakan (dummy display atau VNC).
Akses Android Studio melalui VNC atau headless mode (tanpa GUI).
Ini adalah langkah-langkah lengkap dari awal sampai akhir untuk menjalankan Android Studio di dalam Docker di GitHub Codespaces. Jika masih ada yang membingungkan, beri tahu saya!
