# aur-tester [![](https://images.microbadger.com/badges/image/asm0dey/aur-tester.svg)](https://microbadger.com/images/asm0dey/aur-tester "Get your own image badge on microbadger.com")
Image for testing Arch packages which should be published in AUR

## Usage

It's very simple: 
in directoru, where your `PKGBUILD` is stored, you should run

```shell
docker run -v "$pwd":/pkg asm0dey/aurtester
```
