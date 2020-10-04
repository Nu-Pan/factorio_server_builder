load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "pkg_usr_bin",
    package_dir = "/usr/bin",
    srcs = glob(["*.sh"]),
    mode = "0755",
)

pkg_tar(
    name = "pkg_opt_local_script",
    package_dir = "/opt/local/script",
    srcs = glob(["*.py"]),
    mode = "0755",
)

pkg_tar(
    name = "pkg_opt_local_factorio",
    package_dir = "/opt/local/factorio",
    srcs = glob(["server-adminlist.json"]),
    mode = "0755",
)

pkg_tar(
    name = "pkg",
    deps = [
        ":pkg_usr_bin",
        ":pkg_opt_local_script",
        ":pkg_opt_local_factorio",
    ],
    visibility = ["//visibility:public"],
)
