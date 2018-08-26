# aur-tester
Image for testing Arch packages which should be published in AUR

## Usage

It's very simple: 
in directoru, where your `PKGBUILD` is stored, you should run

```shell
docker run -v "$pwd":/pkg asm0dey/aurtester
```
