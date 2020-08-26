load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "pkg",
    strip_prefix=".",                   # . を指定しないとディレクトリ構造を無視して flatten に展開されてしまう
    package_dir = "/opt/local/hoge",    # strip_prefix を指定すると何故か１階層上ってしまうので１階層余分に掘っておく
    srcs = [
        "@factorio//:srcs",
    ],
    mode = "0755",
    visibility = ["//visibility:public"],
    symlinks = {"/usr/bin/factorio": "/opt/local/factorio/bin/x64/factorio"},
)
