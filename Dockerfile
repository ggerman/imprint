FROM ruby:3.3

RUN apt update && apt -y upgrade
RUN apt install -y \
  libgd-dev libgd3 libgd-tools \
  pkg-config ruby-dev build-essential valgrind python3

RUN printf "prefix=/usr\n\
exec_prefix=\${prefix}\n\
libdir=\${exec_prefix}/lib/x86_64-linux-gnu\n\
includedir=\${prefix}/include\n\
\n\
Name: gd\n\
Description: GD Graphics Library\n\
Version: 2.3\n\
Libs: -L\${libdir} -lgd\n\
Cflags: -I\${includedir}\n" \
> /usr/lib/x86_64-linux-gnu/pkgconfig/gd.pc

ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

RUN gem update --system 4.0.4

WORKDIR /app
