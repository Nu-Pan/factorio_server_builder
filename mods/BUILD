load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

genrule(
    name = "factorio-world",
    tools = ["download.sh"],
    srcs = ["authentication.json"],
    outs = ["factorio-world_0.18.2.zip"],
    cmd_bash = "./mods/download.sh $@ 4699eed61dc2f49dab9c1020a7066ba50328fbc0 $<",
)

genrule(
    name = "Enhanced_Map_Colors",
    tools = ["download.sh"],
    srcs = ["authentication.json"],
    outs = ["Enhanced_Map_Colors_1.5.3.zip"],
    cmd_bash = "./mods/download.sh $@ 02552e2caf562fe27fb7b7a16fa6ee6976b23d8b $<",
)

pkg_tar(
    name = "pkg",
    srcs = [
        ":factorio-world",
        ":Enhanced_Map_Colors",
    ],
    package_dir = "/opt/local/factorio/mods",
    visibility = ["//visibility:public"],
)
