load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "pkg_usr",
    package_dir = "/usr/bin",
    srcs = glob(["*.sh"]),
    mode = "0755",
)

pkg_tar(
    name = "pkg_opt",
    package_dir = "/opt/local/script",
    srcs = glob(["*.py"]),
    mode = "0755",
)

pkg_tar(
    name = "pkg",
    deps = [
        ":pkg_usr",
        ":pkg_opt",
    ],
    visibility = ["//visibility:public"],
)
