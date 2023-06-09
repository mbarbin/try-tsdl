# try-tsdl

[![CI Status](https://github.com/mbarbin/try-tsdl/workflows/ci/badge.svg)](https://github.com/mbarbin/try-tsdl/actions/workflows/ci.yml)

I had a build issue in the GitHub Actions of another project that depends on tsdl, so I reproduced the issue here with a smaller repo.

## Build issue

https://github.com/dbuenzli/tsdl/issues/92

The issue happens during the execution of the GitHub Actions workflow.

```
2023-04-04T13:21:28.3169805Z /usr/bin/sudo "apt-get" "install" "-qq" "-yy" "libsdl2-dev" "libsdl2-image-dev"
2023-04-04T13:21:32.2273577Z Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/libpulse0_15.99.1%2bdfsg1-1ubuntu2_amd64.deb  404  Not Found [IP: 52.154.174.208 80]
2023-04-04T13:21:32.2274771Z Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/libpulse-mainloop-glib0_15.99.1%2bdfsg1-1ubuntu2_amd64.deb  404  Not Found [IP: 52.154.174.208 80]
2023-04-04T13:21:32.2275957Z Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/libpulse-dev_15.99.1%2bdfsg1-1ubuntu2_amd64.deb  404  Not Found [IP: 52.154.174.208 80]
2023-04-04T13:21:32.2276887Z Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
```

When I look directly at
http://azure.archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/ with a
browser, indeed I don't see this file:

> libpulse0_15.99.1%2bdfsg1-1ubuntu2_amd64.deb

However there is a 2.1 of the same file.

http://azure.archive.ubuntu.com/ubuntu/pool/main/p/pulseaudio/libpulse0_15.99.1%2bdfsg1-1ubuntu2.1_amd64.deb

This issue started to happen perhaps a month ago.

## Fix

I stumbled upon the following, and the suggested work-around worked for me:

https://github.com/actions/runner-images/issues/192

> For anyone landing here from a google search and still interested to install SDL2 you can follow this article CI workflow https://alexene.dev/2019/09/04/Github-actions-CI-rust-SDL2.html
> 
> Here's the solution for Ubuntu:
> 
> ```
> steps:
>     - uses: actions/checkout@v1
>     - name: install_dependencies
>       run: |
>         sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu `lsb_release -sc` main universe restricted multiverse"
>         sudo apt-get update -y -qq
>         sudo apt-get install libsdl2-dev
> ```

